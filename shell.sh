#!/bin/sh
apt update
apt install openjdk-8-jdk maven -y
git clone https://github.com/wakaleo/game-of-life.git
cd game-of-life
mvn install
cd gameoflife-web
mvn jetty:run