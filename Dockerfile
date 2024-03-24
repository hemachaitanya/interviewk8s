FROM ubuntu:22.04 as basics
ARG USER=spc
ARG JAVA_PACKAGE=openjdk-17-jdk
ARG USER_SHELL=/bin/sh
RUN apt update && apt install ${JAVA_PACKAGE} -y && \
    apt install wget git -y 

FROM ubuntu:22.04 as maven
COPY --from=builder --chown=${USER}:${USER} 
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
RUN ls && tar xzvf apache-maven-3.9.6-bin.tar.gz -C /usr/share/maven
RUN echo "export PATH="/use/share/maven/apache-maven-3.9.6/bin:$PATH"" >> ~/.bashrc
RUN source ~/.bashrc
RUN maven version

FROM maven:3-amazoncorretto-17 AS app
COPY --from=maven --chown=${USER}:${USER}
RUN git clone https://github.com/spring-projects/spring-petclinic.git
WORKDIR /spring-petclinic
RUN mvn package 
WORKDIR  /spring-petclinic/target

FROM nginx
COPY --from=app --chown=${USER}:${USER} /spring-petclinic/target/spring-petclinic-3.1.0-SNAPSHOT.jar  spring-petclinic-3.1.0-SNAPSHOT.jar
add spring-petclinic-3.1.0-SNAPSHOT.jar /usr/share/nginx 
EXPOSE 80
CMD [ "systemctl","restart","nginx" ]




