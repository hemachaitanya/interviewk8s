# interviewk8s commands 

## create

kubectl create job jobname --image=httpd

kubectl create deploy deployname --image=nginx

kubectl create cronjob time --image=caddy --schedule="30 1 * * 0"

kubectl create secret generic my-secret --from-file=/etc/passwd

kubectl create networkpolicy hema --pod-selector=app=frontend --policy-types=ingress --ingress.from.pod-selector=app=backend --ingress.ports.protocol=TCP --ingress.ports.port=80

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
* 



