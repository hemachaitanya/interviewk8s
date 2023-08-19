
### Kubernetes (K8s)

 is an open source system to deploy, scale, and manage containerized applications anywhere

### container orchistration
         
###         master component

### kubeapi server: 
Handles all the communication of k8s cluster
Let it be internal or external
kube-api server exposes functionality over HTTP(s) protocol and provides REST API

### etcd:
* This is memory of k8s cluster(etcd is stateful means all the information in k8s stored in local)

### sheduler:
* Scheduler is responsible for creating k8s objects and scheduling them on right node

### controller:
* Controller Manger is responsible for maintaining desired state
* This reconcilation loop that checks for desired state and if it mis matches doing the necessary steps is done by controller
    ### node controller
    noiticing and responce when nodes goes down
    ### replication controller
        maintaining correct no. of pods in any replication controller manage
    
    ### endoint controller
    populates the endpoint objects
    

###         node component

### kubelet:

* This is an agent of the control plane

### container run time

* Container technology to be used in k8s cluster
in our case it is docker.

### kube proxy

* This component is responsible for networking for containers on the node

### pod:
smallest unit n k8S

###             Pod lifecycle
K8s Pods will have following states

Pending: creating the pod 

    (1) single container in pod

    (2) multi container in pod 
        maximum we use single container in the pod because multi containers prefer multi applications so we need to scalling only one application pod not supported

Running: starting the pod

Succeded: terminated

Failed: 

###  Container States in k8s pod :

Waiting:

If a container is not in either the Running or Terminated state, it is Waiting. A container in the Waiting state is still running the operations it requires in order to complete start up: for example, pulling the container image from a container image registry, or applying Secret data

Running: 

The Running status indicates that a container is executing without issues. If there was a postStart hook configured, it has already executed and finished.

Terminated:

A container in the Terminated state began execution and then either ran to completion or failed for some reason.

### container policies:

Lets try to create a short lived contianer with different restart policies
    always:
    never:

    onfailure: 
    
exit code => success(0)
exit code => failure(1)

### container: 
three types of containers

###    (1) init container:
            specialized containers that run before app containers in a Pod. Init containers can contain utilities or setup scripts not present in an app image.

###    (2) ephermeral container:
            no guarente containers(debugging)
            Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. This field is alpha-level and is only honored by servers that enable the EphemeralContainers feature.

###    (3) application container :
            these are why we write pod spec

###         containers helth check 
         K8s supports 3 kinds of checks

###   (1)liveness probe:
     if this check fails kuberenetes will restart the container.

###   (2)readiness probe:
        if this check fails the pod will be removed from service (pod will not get requests from service)

###   (3)startup probe: 
        This checks for startup and until startup is ok, the other checks will be paused.
 
    
    Probes or checks can be performed by
* exec: run any linux/windows command which returns status/exit code.

* http: we send http request to the application. based on status codes we can decide Refer Here

* grpc: This communicates over grpc

 * tcp: send tcp request

###  replication controller: 
* replication controller depends on labels , these labels are two types 

 ###   (1) equality based:
 (ReplicationController only allows equality based selectors)

    Equality- or inequality-based requirements allow filtering by label keys and values. Matching objects must satisfy all of the specified label constraints, though they may have additional labels as well

  ###  (2) set based:(where as ReplicaSet supports set based selectors also)

    Set-based label requirements allow filtering keys according to a set of values. Three kinds of operators are supported: in,notin and exists (only the key identifier).
    
     For example:

        environment in (production, qa)
        tier notin (frontend, backend)

* ### for communication of nodes we use (services)
![image](./images/1.png)

*   K8s as a service basically means the master nodes will be managed by cloud provider
![image](./images/2.png)

* Cluster ip:
 internal communication

* Node Port:
   k8s will expose the application on a port on every node in k8s cluster.
![images](./images/3.png)
* LoadBalancer:
 This is generally used with managed k8s clusters

 ![images](./images/4.png)

* external:( C- name DNS)

## deployment

### (1) canary:
      new and old versions are in container , but we have monitoring service  on new version incase new version is working accuratly all old version pods are kill and only new version  pods create orderly

      (release a new version to a subset of users, then proceed to a full rollout)

### (2) recreate
:terminate the old version and release the new one

### (3) ramped: 
 for very older applications ; release a new version on a rolling update fashion, one after the other 

### (4) blue/green:
 release a new version alongside the old version then switch traffic

### (5) A/B  testing:
release a new version to a subset of users in a precise way (HTTP headers, cookie, weight, etc.). A/B testing is really a technique for making business decisions based on statistics but we will briefly describe the process


### (6) roolback and rool out: 
anycomplexities on new version pod takes old version  is called roolback
new versiom is called roolout

### taint & affiniti

pods assigned to the nodes by using sheduler its checks spu,memory,ram ...... some env variables of nodes and pods is called affinity
 * affinity are two types those are
                                 (1)pod affinity
                                 (2)node affinity
  * taint is opposite of affinity
    means you want to remove (repulse) pods to node is called taint

----------------------------
### Kubernetes api versioning

* To k8s cluster we directly or indirectly using kubectl speak with API Server

* k8s has lot of features underdevelopment, stable, improvements

    There are 3 channels for objects/features

        alpha : have create community ; for ex: cloude native k8s there might be change in API gateway also but it don't use in production

        beta : after alpha we did not remove that changes in this beta stage , and small changes will occures 

        stable : all features within the API group is specified in a REST path and in the api version serialized object.

    *  Every thing in k8s is an object.
        To declare an object, we need to specify 4 fields

    * kind is type of object

    * metadata describes some additional information about object you are trying to create (name, labels)

    * spec: This is the desired state

    * To get all the api-resources in your k8s cluster (kubectl api-resources)

### helm (old version tinnel)
    disadv: basically 
    *  helm is a package manager for k8s (like apt is package manager for ununtu)

  * helm is to run dynamic yaml files(ex: echo "hema" = static)
        ( name=hema ; echo 'welcome $name' = dynamic )
    # new loadbalancer in every service is a  not good because it is very cost
    good idea is(ingress controller: controller is third party) use reusable loadbalances or lb work on layer 4 (port and tcp)

    /catalog
    /log
    /identity.qt.com
    no need it we need http/ adress name
    we need layer 7 (path based / hostname based)

      my company "f5" load balancer big hardware service load balancer

### kustamize 

kustamize is nothing but module

* kustamise also a dynamical yaml approch , it's override approch , kustamize nativelly supports kubectl (latest versions)

 kustumize adv is we directly run from git environment 
 ![image](./images/5.png)
 # kubectl apply -k .     (means  kustomize directory)

## interview (q)

helm is package manager in k8s
y u use this helm
 helm chat is very easy to deploy by using (helm install<nameof application>)

        helm install [chat] [wr chat present] []

### patching
 patching means changing
 i have a  patch for service 
 type will be change in port
 type will be change in loadbalanceer
------------------------------
build image code
terraform apply

kms(aws)
key valut (azure)
hashi crop vault


most common failures in k8s
-----------------------------------------------------------------------
### deamon set
*  we want to attach pod to every node beacause of metrics , logs , and monitoring , fileagent purpose 
* DaemonSet is a controller which creates pod on every/selected nodes in k8s cluster
Use cases:
   *  log collectors
   *  agents etc

![image](./images/6.png)

### affinity/anti affinity:
* Schedule a Pod using preferred node affinity

*  how to assign a Kubernetes Pod to a particular node using Node Affinity in a Kubernetes cluster.

        kubectl get nodes --show-labels
* nodeAffinity: Describes node affinity scheduling rules for the pod.

* podAffinity: Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).

* podAntiAffinity: Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))

### taint and tolarasions:
taint is cannot assigning(con't working) pods in perticular node 

 taint is node level
 tolaration is pod level

 #### noshedule: 
 already executed pods will be running . but new pods can't attached
 #### prefer noshedule:
 which must be of effect NoExecute, otherwise this field is ignored
 #### evict(no execute):
 delete all the pods previously created in the node 


    kubectl taint nodes node1 key1=value1:NoSchedule

### node selector

When we have tried to create a pod with nodeSelector matching purpose: poc it was created on node 0 and when we created a pod with purpose:
 testing it created in node 1 and when created a pod with purpose: 
 development it was in pending state (not created)

* ### service:
* services are two types 
(1)internal service : cluster ip
(2)external service : node port , load balancer

* When upgrading to newer versions of Pods ensure right set of labels are present on k8s service selector


### headless services:
 * Headless service will not have cluster ip
 * Headless service returns the ips of the pods returned by selector.
 * This is used in stateful sets

 ### stateful set: 

 Statefulset is like deployment with replicas. But each pod gets its own volume.
 When we create replicas in Stateful Set we get predictable names
  We can access individual pod, by creating headless service and by using ...svc.cluster.local
 


  load balancer sends traffic into main pod after that creating pod pods maintainerssame data in mainpod copied into the remaining pods .

 ### stateless service:

 load balancer send traffic into the  differend pods wich one have less traffic deals

 ### volumes

 Volume represents a named volume in a pod that may be accessed by any container in the pod.

  it is temporarystorage we delete pod storage of data(information) also deleted

  ### ephermal volume:
 ### config:
 ### secret: 
  ### ephermal:
  ### persisted: 
  when we delete  pods then data also deleted 

  persisted volumes have storage clasess
  these storage classes are used for communicate with cluster storages (in aws ecs)


  # ADOM K8S

  ![hema](./images/A1.png)
  ![hmea](./images/A2.png)
  ![lll](./images/A3.png)
  ![hema](./images/A4.png)
  ![hema](./images/A5.png)
  ![hema](./images/A6.png)
  ![hema](./images/A7.png)
  ![hema](./images/A8.png)
  ![hema](./images/A9.png)
  ![hema](./images/A10.png)
  ![hema](./images/A11.png)
  ![hema](./images/A12.png)
  ![hema](./images/A13.png)
  ![hema](./images/A14.png)
  ![hema](./images/A15.png)
  ![hema](./images/A16.png)
  ![hema](./images/A17.png)
  ![hema](./images/A18.png)
  ![hema](./images/A19.png)
  ![hema](./images/A20.png)
  ![hema](./images/A21.png)
  ![hema](./images/A22.png)
  ![hema](./images/A23.png)
  ![hema](./images/A24.png)
  ![hema](./images/A25.png)
  ![hema](./images/A26.png)
  ![hema](./images/A27.png)
  ![hema](./images/A28.png)
  ![hema](./images/A29.png)
  ![hema](./images/A30.png)
  

  * PERSISTENT VOLUME (static volume persistence)
    * because we previously create one volume(EBS)   in  aws cloud

   create one object in ur k8s cluster , in cloud you need to create storage in aws , map that storage into k8s cluster is called prsistent volume. 

   ![hema](./images/A31.png) 
   ![hema](./images/A32.png)
   ![hema](./images/A33.png)



* persistance volume claim: which  is available to match that's the persistent volume

![hema](./images/A34.png)

* persistent volume provisioning

![Alt text](./images/A35.png)

 ### health check

 * application in running but its not working properly we need health check
 ![aaa](image/A36.png)
 ![hema](./images/A37.png)


## k8s config & secrete
* k8s me wil write one config file it reads the file and will be store it on a vertual memory , which will come inside the pod.

* The file in which you are sharing some content  which needs to be availabe inside the container  ifthis file containes application detailes file , the file which have configuration details (db details, ) i called configuration map

* the file can have sensitive data is called secrets . 
* content of ur container you don't have content of the file access it as a environment variable in container .
![hema](./images/A38.png)
![hema](./images/A39.png)
![hema](./images/A40.png)
* 
  ## KOPS INSTALLATION 

  * kops means k8s operations , kops is a free and open source command line tool for configuring and maintaining k8s clusters and provisioning the cloud infrastructure needed to maintain them . kops is officially supported and widely used on aws , and is expanding to support multiple additional cloud platforms.

  #### kops prerequisites 

  (1) aws account

  (2) deploy or create one management server which holds all scripts

  (3) s3 bucket

  (4) route 53 domain integration 

  (5) kops binary and kubectl binary

  (6) ssh public and private key

  (7) aws access key and secret key (aws cli for configuring)

  #### kops installation
  * create one ec2 instance
  * <https://github.com/kubernetes/kops/releases/download/v1.27.0/kops-linux-amd64>
  * chmod 700 kops-linux-amd64
  * mv kops-linux-amd64 kops
  * mv kops /usr/local/bin/
  * kops version
  * <curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl>
  * chmod 700 kubectl
  * mv  kubectl /usr/local/bin/
  * ssh-keygen
  * awscli installation and configuration
  * kops create cluster --name=<our choice> --state=<bucketname> --zones=<namezone> --node-count=<number> --node-size=<t2....> --master-size=<t2..> --master-volume-size=<our choice> --node-volume-size=<> --dns-zone=<DNS name>

  * kops create cluster --name=sohail666.xyz --state=s3://sohail666.xyz --zones=us-east-1a --node-count=1 --node-size=t2.medium --master-size=t2.medium --master-volume-size 20 --node-volume-size 10 --dns-zone=sohail666.xyz
  *kops get ig
   *   kops get ig --state=s3://chaitu.xyz --name=babool.xyz
   *  kops edit ig <control-plane-ap-south-1a> --state=s3://chaitu.xyz
   *  kops edit ig nodes-ap-south-1a --state=s3://chaitu.xyz
   *  kops update cluster --state=s3://chaitu.xyz --yes 
   * kops update cluster  --name=<our choice> --state=<bucketname> --yes
   * kops get cluster --state=<statefilename(bucket name)>
   * kops delete cluster --state=<statefile> --name=<clustername> --yes
  


  


  ### kube spray 
  * kubespray is a composition of ansibe playbooks , inventory , provisioning tools and domain knowledge for generic OS or k8s clusters configuration management tasks 

