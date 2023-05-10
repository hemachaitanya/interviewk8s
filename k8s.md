
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

### (2) recreate:

### (3) ramped: 
 for very older applications ; release a new version on a rolling update fashion, one after the other 

### (4) blue/green:
 release a new version alongside the old version then switch traffic

### (5) A/B  testing:
release a new version to a subset of users in a precise way (HTTP headers, cookie, weight, etc.). A/B testing is really a technique for making business decisions based on statistics but we will briefly describe the process


### (6) roolback and rool out: 
anycomplexities on new version pod takes old version  is called roolback
new versiom is called roolout