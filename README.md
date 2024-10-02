

### namespace level



Pods		,
Services		,
Deployments		,
StatefulSets		,
ReplicaSets		,
ConfigMaps		,
Secrets		,
Ingresses		,
PersistentVolumeClaims		,
NetworkPolicies		,
ResourceQuotas		,
Roles		,
RoleBindings		,
LimitRanges		.

### cluster level


Namespaces	,	
Nodes	,	
PersistentVolumes	,	
ClusterRoles	,	
ClusterRoleBindings	,
StorageClasses	,	
CustomResourceDefinitions,	Yes	
APIService	,	
ClusterIssuers (cert-manager),
PodSecurityPolicies	,	
ValidatingWebhookConfigurations	,	
MutatingWebhookConfigurations	.	

# interviewk8s commands 

* kubectl get pod/pod-name deployment/deployment-name job/jobname ...... resource-type/resource-name

* kubectl apply -f one.yaml -f two.yaml -f...n.yaml

* kubectl create ns namespace-name

* kubectl config set-context --current --namespace=<namespace-name>

* kubectl api-resources

* kubectl get pods -o json | jq -r '.items[] | .metadata.name as $pod | .spec.containers[] | "\($pod): \(.name)"'

### i want to check the inside pod container names for each pod
* create list-containers.sh

```
for pod in $(kubectl get pods -o jsonpath='{.items[*].metadata.name}'); do
  echo "Pod: $pod"
  kubectl get pod $pod -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n'
done
```
### container names in pod
```container.sh
#!/bin/bash

# Get all pod names in the current namespace (or specify a namespace with -n <namespace>)
pods=$(kubectl get pods -o jsonpath='{.items[*].metadata.name}')

# Loop through each pod and get its container names
for pod in $pods; do
    echo "Pod: $pod"
    containers=$(kubectl get pod $pod -o jsonpath='{.spec.containers[*].name}')
    
    # Print each container name inside the pod
    for container in $containers; do
        echo "  Container: $container"
    done
done
```


* chmod +x list-containers.sh

* ./list-containers.sh

* (cluster name) kubectl config current-context

* (cluster yaml) kubectl config view

* kubectl exec -it hema -- mkdir -p /ram/application

* verify this path will be created or not 

* kubectl exec -it hema -- ls -d /ram/application

* kubectl completion bash

* kubectl convert -f filename --dry-run

* kubectl cp (source-file)  pod-name:(destination-path)

* kubectl cp pod.yaml hema:/ram/application


```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata: 
  clusterName: kubernetes-admin@kubernetes
  name: hema
  namespace: defalut
  labels:
    app: caddy
    auther: hemachaitanya
spec:
  minReadySeconds: 5
  replicas: 2
  selector: 
    matchExpressions:
      - key: app
        operator: in
        values:
          - web
            application
            db
  strategy: 
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 30%
      maxUnavailable: 30%
  template:
    metadata:
      clusterName: kubernetes-admin@kubernetes
      name: hemalatha
      labels: 
        app: web
        app: application
    spec:
      containers: 
        - name: container
          image: caddy
          tty: true
          ports:
            - name: hema
              containerPort: 80
              protocol: 80
---
apiVersion: v1
kind: Service
metadata:
  name: hema-svc
spec:
  selector:
    app: web
  type: ClusterIP
  ports:
    - port: 80
      protocol: TCP
      targetPort: 80

    


 


```


## create

* kubectl create job jobname --image=httpd

* kubectl create deploy deployname --image=nginx

* kubectl create cronjob time --image=caddy --schedule="30 1 * * 0"

* kubectl create secret generic my-secret --from-file=/etc/passwd

* kubectl create networkpolicy hema --pod-selector=app=frontend --policy-types=ingress --ingress.from.pod-selector=app=backend --ingress.ports.protocol=TCP --ingress.ports.port=80

* kubectl create --help

* Available Commands:
  clusterrole           Create a cluster role
  clusterrolebinding    Create a cluster role binding for a particular cluster role
  configmap             Create a config map from a local file, directory or literal value
  cronjob               Create a cron job with the specified name
  deployment            Create a deployment with the specified name
  ingress               Create an ingress with the specified name
  job                   Create a job with the specified name
  namespace             Create a namespace with the specified name
  poddisruptionbudget   Create a pod disruption budget with the specified name
  priorityclass         Create a priority class with the specified name
  quota                 Create a quota with the specified name
  role                  Create a role with single rule
  rolebinding           Create a role binding for a particular role or cluster role
  secret                Create a secret using a specified subcommand
  service               Create a service using a specified subcommand
  serviceaccount        Create a service account with the specified name
  token

     --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the
        template. Only applies to golang and jsonpath output formats.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that
        would be sent, without sending it. If server strategy, submit server-side request without
        persisting the resource.

    --edit=false:
        Edit the API resource before creating

    --field-manager='kubectl-create':
        Name of the manager used to track field ownership.

    -f, --filename=[]:
        Filename, directory, or URL to files to use to create the resource

    -k, --kustomize='':
        Process the kustomization directory. This flag can't be used together with -f or -R.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template,
        templatefile, jsonpath, jsonpath-as-json, jsonpath-file).

    --raw='':
        Raw URI to POST to the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
        Process the directory used in -f, --filename recursively. Useful when you want to manage
        related manifests organized within the same directory.

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise,
        the annotation will be unchanged. This flag is useful when you want to perform kubectl
        apply on this object in the future.

    -l, --selector='':
        Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l
        key1=value1,key2=value2). Matching objects must satisfy all of the specified label
        constraints.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file.
        The template format is golang templates
        [http://golang.org/pkg/text/template/#pkg-overview].

    --validate='strict':
        Must be one of: strict (or true), warn, ignore (or false).              "true" or "strict" will use a
        schema to validate the input and fail the request if invalid. It will perform server side
        validation if ServerSideFieldValidation is enabled on the api-server, but will fall back
        to less reliable client-side validation if not.                 "warn" will warn about unknown or
        duplicate fields without blocking the request if server-side field validation is enabled
        on the API server, and behave as "ignore" otherwise.            "false" or "ignore" will not
        perform any schema validation, silently dropping any unknown or duplicate fields.

    --windows-line-endings=false:
        Only relevant if --edit=true.


  ## run

  * kubectl run <name of pod> --image:jenkins/jenkins:latest
 
  * kubectl run nginx --image=nginx --replicas=3 --port=80
 
  ## cp :Copying files from a pod to your local machine

  * kubectl cp <file_path> <pod_name>:<container_path>

  * kubectl cp config.yaml my-pod:/app/config
 
  * in case you face any error
 
  * kubectl exec -it nginx -- mkdir -p /app/config
  
   * kubectl cp congig.yaml nginx:/app/config
 
* check this file is copied or not by

* yaml.yaml

* cat yaml.yaml 
---
- name: install nginx  
  become: yes
  hosts: all

* sed -i 's/- name: install nginx/name: hema/' yaml.yaml
* cat yaml.yaml

* - name: hema  
  become: yes
  hosts: all

 ## apply

 * kubectl apply -f <ymal-file>

 * --wait=false:
        If true, wait for resources to be gone before returning. This waits for finalizers.

* --prune=false:
        Automatically delete resource objects, that do not appear in the configs and are created
        by either apply or create --save-config. Should be used with either -l or --all.





## what is the defference between the deployment and headless service 

* in deployment pods will be crated parllel 
* in statefulset pods will be created both parellel and sequential order 

* in deployment we delete pods in sequential

* in stateful set pods will be deleted LIFO ordr

### voumes 

#### RWO : 
 
 * ONLY IN ONE MACHINE WE  read , write in one pod

 #### rwonce :

 * one read , write pod will be created 



