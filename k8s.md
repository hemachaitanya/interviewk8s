
### Kubernetes (K8s)

 is an open source system to deploy, scale, and manage containerized applications anywhere

### container orchistration

#### quoram:
   

   the minimum number of memebers in assembly or society 
        that must be present at any of that meeeting to make the proceding of that meeting valid.
        
         
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
![hema](./images/A44.png)
![heam](./images/A45.png)
```yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 2Gi
  accessModes: 
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle 
  awsElasticBlockStore:
    volumeID: <instance volume id>
    fsType: ext4
    
    
```
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-utilizes
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi

```
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

  ### k8s errors:

  ##  (1) image pull backoff , ErrImagePull
   
   * wrong container image (path by mistake)
   * trying to use private images with out providing regstry credentials (like ecr with out credentials )
   * image does not exists

## (2) crashloop back off
   
   * in single pod  multiple containers are presented , in that two containers have running application in same port (httpd , nginx) then crash loop backoff error will be occures

   * when you are launching a new application on k8s having the application crash on startup is a common occurence .
   * we can see that application exit code is 1 , we might also see an OOMKilled error (first thing we can do is check our application logs (kubectl logs <pod name>))

## (3)  run container error

     * Missing ConfigMap or Secret

     * Kubernetes best practices recommend passing application run-time configuration via ConfigMaps or Secrets. This data could include database credentials, API endpoints, or other configuration flags.

    * A common mistake that I've seen developers make is to create Deployments that reference properties of ConfigMaps or Secrets that don't exist or even non-existent ConfigMaps/Secrets. 
## (4)  if we  are unable to  delete pods for any reason

   *  for every pod  we have some finalizers , so we should un-comment  and then delete the pod .


  ### KUBERNETES

  * kubectl create job  <job name> --image=<image name>

  * kubectl get po

  * kubectl exec -it <pod name> -- /bin/bash

      apt update && apt install net-tols -y
      ifconfig

  * kubectl create job alpine --image=alpine -- sleep -- 1d

## sidecar - container 

* Sometimes we might need extra functionality to inject log exports, network monitoring, tracing, then we can add one more container as side car in your pod

(1) Write a Manifest for a Pod which runs two containers
name is first & image is alpine sleep 1d
name is second & image is ubuntu sleep 1d

*   kubectl exec -it -c <container name> <podname> -- /bin/sh

      #### docker container run --name <identifying name> -d -P <image name>

      #### docker container logs <identifying name>

      ####  docker container run --name <identifyingname> -P -d --cpus="1" --memory 512m <image-name>

### container states in a pod

  * running
  * terminated
  * waiting
### pod states in job

  * pending
  * runnng
  * succeded
  * failed
  * unknown
###  Labels && annotations

* kubectl run frontend --image=httpd --restart=Never --labels=env=prod,team=admin

* kubectl run backend --image=httpd --restart=Never --labels=env=prod,app=apache

* kubectl run database --image=httpd --restart=Never --labels=env=prod

* kubectl get po --show-labels

* kubectl describe pods 

*  kubectl label pods backend env-

*  kubectl get pods --show-labels

* kubectl get pods -l 'team in (admin)',env=prod --show-labels

* apt update && apt install tmux -y



### RBAC (ROLL BASED ACCESS CONTROLE)

*  kubectl auth can-i -h (or) --help

* in k8s we give permissions for NODE authentication , ABAC , RBAC & web hook autharization (permisssions or autheraizations are applicable for users , groups , service account)

* we give access to the team members for operating access . (delete, create , update , patch , list , get ....) this are called VERBS

* above operations applicable for resources (configmaps , pods , secretes , deployment , PV and pvc ....)

* kubectl api-resources

* kubectl create job --image:caddy >> job.yaml

* kubectl create namespace <name> >> ns.yaml

* kubectl get ns

* kubectl congif set-context --current --namespace=<new-namespace>

* kubectl get role

* kubectl get rolebinding

*  mkdir cert

* cd cert

* openssl genrsa -out <name>.key <size> ## size like 2048 ,1024

* openssl req -new -key <name>.key -out <name>.csr -subj "/CN=<name>/O=learning"

* openssl x509 -req -in <name>.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out <name>.crt -days 120

* kubectl config set-credentials <name> --client-certificate=<name>.crt --client-key=<name>.key

* kubectl config set-context <name>-context --cluster=kubernetes --user=<hema>

* kubectl config use-context <name>-context

### create one service account 
apiVersion: v1
kind: ServiceAccount
metadata:
  name: robo
automountServiceAccountToken: true

### attach service account to pod

---
apiVersion: v1
kind: Pod
metadata:
  name: robotrails
spec:
  serviceAccountName: robo
  containers:
    - name: nginx
      image: nginx
### create a role name as foramlity

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: formality
rules:
  - apiGroups:
      - ""
    resources:
      - pods
      - services
    verbs:
      - list
      - get
      - watch
  - apiGroups:
      - apps
    resources:
      - deployments
    verbs:
      - list
      - get
      - watch

### create a role binding 

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: formality-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: formality
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: <name>
  - kind: ServiceAccount
    name: robo

### Role and RoleBindings apply to a particular namespace

### commands to upgrate kubernetes version from old version to new version

![hema](./images/updateversion.png)

 ## commands to update controle plane

      sudo apt-mark unhold kubelet kubeadm kubectl
      curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
      echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
      sudo apt-get update
      sudo apt-cache madison kubeadm
      sudo apt-get install kubeadm=1.27.4-1.1 && sudo apt-mark hold kubeadm
      kubeadm version
      sudo kubeadm upgrade plan
      sudo kubeadm upgrade apply v1.27.4
      kubectl drain ip-172-31-33-86 --ignore-daemonsets
      sudo apt-m  ark unhold kubelet kubectl && sudo apt-get install -y kubelet=1.27.4-1.1 kubectl=1.27.4-1.1 && sudo apt-mark hold kubelet kubectl
      sudo systemctl daemon-reload
      sudo systemctl restart kubelet.service
      kubectl uncordon ip-172-31-33-86
      kubectl get nodes


## commands to update worker node 


    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-mark unhold kubelet kubeadm kubectl
    sudo apt-cache madison kubeadm
    sudo apt-get install kubeadm=1.27.4-1.1 && sudo apt-mark hold kubeadm
    sudo kubeadm upgrade node
    kubectl get nodes
    kubectl drain ip-172-31-40-43 --ignore-daemonsets
    sudo apt-mark unhold kubelet kubectl && sudo apt-get install -y kubelet=1.27.4-1.1 kubectl=1.27.4-1.1 && sudo apt-mark hold kubelet kubectl
    sudo systemctl daemon-reload
    sudo systemctl restart kubelet.service
    kubectl uncordon ip-172-31-40-43


## NAMESPACE

  * namespace are a way to organize cluster into vertual sub-clusters

  * kubectl create namespace <name>

  * kubectl get --all -namespaces

  * kubectl get pods -n <name-of-namespace>

  * kubens <namespace-name>

  * kubectl delete pods --all -n <name-of-ns>

  * kubectl config set-context --current --namespace=<name-of-ns>

          current-context   Display the current-context

      delete-cluster    Delete the specified cluster from the kubeconfig

      delete-context    Delete the specified context from the kubeconfig

      delete-user       Delete the specified user from the kubeconfig

      get-clusters      Display clusters defined in the kubeconfig

      get-contexts      Describe one or many contexts

      get-users         Display users defined in the kubeconfig

      rename-context    Rename a context from the kubeconfig file

      set               Set an individual value in a kubeconfig file

      set-cluster       Set a cluster entry in kubeconfig

      set-context       Set a context entry in kubeconfig

      set-credentials   Set a user entry in kubeconfig

      unset             Unset an individual value in a kubeconfig file

      use-context       Set the current-context in a kubeconfig file
      
      view              Display merged kubeconfig settings or a specified kubeconfig file
      
### CNI:

*  K8s dictates the following requirements

    All Pods must communicate with each other without NAT

    Nodes can communicate with Pods without NAT

    Pod ip address is same as those outside the Pods that it sees itself

* With the above constraints we have 4 distinct network problems 

    Container to Container networking

    Pod to Pod Networking

    Pod to Service Networking

    Internet to Service Networking

* (1) container to container networking 

      two pods inside the containers shares the same network  namespace

      * create 2 containers in the one pod and give the names for each containers 
      
      * kubectl apply -f <name.yaml>

      * kubectl get po -owide

      * kubectl exec -it <podname> -c <contkubectl exec -it mypod -c container1 -- /bin/bash ainer1-name> -- /bin/bash

      * kubectl get pods mypod -o=jsonpath='{range .status.podIP}{"Container 1 IP: "}{@}{"\n"}{end}'

      * kubectl exec -it <poname> -c <container1-name> -- /bin/sh

      * curl http://<podip>:<port-of container 2>

### pod to pod communication with in the same node

* kubectl create job <jobname> --image:<image name>

* kubectl get po -owide

* kubectl exec -it <pod-1 name> -- /bin/sh

    * cat /etc/os-release

    * apk update && apk add curl && apk add net-tools

    * ping http://<pod2-ip>:<port> (or) curl http://<pod2-ip>:<port>

### pod to pod communicaion with in same node but different namespaces 

 * 

### pod to pod communication within the different nodes

* service mechanisum who as access the applications inside the pod/containers

![hema](./images/sevice.completek8s.png)

* kubectl get deploy --all-namespaces

* kubectl get pods --all-namespaces

*  kubectl get deploy --all-namespaces

*  kubectl get deployment.apps -n kube-system coredns -o yaml > deploy.yaml

*  kubectl get svc --all-namespaces

![hema](./images/service-completek8s.png)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  selector:
    app: nginx
  ports:
    - name: nginx-svc
      protocol: TCP
      port: 80
```

* kubectl get svc --all-namespaces

* kubectl get endpoints

* kubectl get endpointslices.discovery.k8s.io

![hema](./images/complete8s-svc-3.png)

##### Endpoints help identify what pods are running for the service, Endpoints are created and managed by services

```yaml
apiVersion: v1
kind: Endpoints
metadata:
  name: nginx-svc
subsets:
- addresses:
  - ip: 192.168.0.8
    nodeName: controlplane
    targetRef:
      kind: Pod
      name: nginx-deployment-cbdccf466-6q5f9
      namespace: default
      uid: 9e2da211-7213-40de-921f-7e871690fcac
  - ip: 192.168.0.9
    nodeName: node01
    targetRef:
      kind: Pod
      name: nginx-deployment-cbdccf466-kxc47
      namespace: default
      uid: 69ea9d52-94fa-4bb9-8650-cddefeb947e8
  ports:
  - name: nginx-svc
    port: 80
    protocol: TCP
```

*  kubectl apply -f endpoint.yaml

### There are four types of services

![hema](./images/servicek8s.png)

#### ClusterIP : 

    two pods present in two diffenent nodes for internanally they communicate with each other by using clusteIP 

    cluster ip is used expose internal communicatin purpose , which means with in the k8s cluster you wolud be able to access the pods

* kubectl get svc

* kubectl port-forward service/api-svc 8080:8080

* curl <ipv4>:8080


![hema](./images/complete-clusterip.png)

#### NodePort:

* incase you have 10 worker nodes , in 10 nodes same applicaiton will be run in the 10 worker nodes the ips will be different , then we will access the single applications with 10 different ip adresses .



![hema](./images/service-nodeport.png)


* node-port type expose to your pod to external network  with the same target port, user can access it using the worker node ip and port  will you exposes.

* user will be access traffic will be send to the respective pods  pods to the service .

* kubectl get svc

* kubectl get pods -owide

* same application runs on two nodes based on node labels

* 
  
    
#### LoadBalancer

* one single ip given to acess the application , we prefer LoadBalancer . the application access out side the cluster also

* but loadbalancer type that will work only in the cloud provider . 

* if in the k8s cluster environment that hosted down any cloud provider like ruby cloud or aws  . then you be able to use the loadbalancer you would get external ip to the load balancer , 

![hema](./images/complet-k8s-Loadbalancer.png)

*  external ip in the Load balancer is chargable

#### ExternalName

![hema](./images/complete-external-ip.png)

## INGRESS(ingress controller+ingress)

* Ingress is k8s specific Layer & HTTP Load Balancer which is accesible
externally 

* out side traffic go to the ingress controller , we have must and should we have ingress config file . then after  it redirect to the traffic .

* 



![hema](./images/complete-k8s-ingresss.png)

* 










    

