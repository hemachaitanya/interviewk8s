### what  is taint and tolerations ?

taint : it's a node level, they allow to repel a set of pods 

    * no schedule

    * prefered node schedule

    * evict

### node affinity & pod affinity

* node selector is a simplest recomended form of node seletion constraints based on node labels .

* node affinity: 

    * required during scheduling and ignore during execution (definatly we want so it is hard)
* preffered  during scheduling and ignore during execution(it's the optional , take weights , )


### jenkins integrated with k8s 
```Jenkinsfile
 pipeline {
    agent {
        label "EEE"
    }
    stages {
        stage('credentials') {
            steps {
                kubeconfig(
                    credentialsId: '27a3af04-2be9-4bfc-9516-34b77aee5f1e',
                    ## below two are visable in "cat /home/user/.kub/config"
                    serverUrl: 'https://34.31.248.141',
                    caCertificate: '''
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVMVENDQXBXZ0F3SUJBZ0lSQUtYWUxvUzJtNnJqcCtWQ1dvdVUvaTB3RFFZSktvWklodmNOQVFFTEJRQXcKTHpFdE1Dc0dBMVVFQXhNa016ZGtOekkwWVRndFlUUXlNeTAwWWpKa0xUazBaVFF0WlRZek1ESXpNR1JrWTJJdwpNQ0FYRFRJME1EWXlNREE0TlRjME9Wb1lEekl3TlRRd05qRXpNRGsxTnpRNVdqQXZNUzB3S3dZRFZRUURFeVF6Ck4yUTNNalJoT0MxaE5ESXpMVFJpTW1RdE9UUmxOQzFsTmpNd01qTXdaR1JqWWpBd2dnR2lNQTBHQ1NxR1NJYjMKRFFFQkFRVUFBNElCandBd2dnR0tBb0lCZ1FDVHhCakx3WU1OdFZBWE4ydjFpTW1LNkdSVURySVFMb0diVmgzeApKNlBQUEV3V2lHMEJDTTVjR1BNZzQ3TmR5akFKOWNaWlo4NU1Nc2NjcGd6dllXVTdSZ05xTjBrUklGdmlWT2w4CjhLTExsdTNaSVgzTGlKYytWYmd4bUFTOTUrWmxzRjZkck9DOG82OE1EcnpxeTE0OGJwTXFwTjRuUGFNVllFTWMKU0dQM1pEdHRSOEp1V1M0OTNsRmxHYlJ5S3pobUtzTFFZamVLMDQrSEZ6Um0rd2ZtMzZlanpValVBSkEzcDNmTgpicG5odjk1S2puZ2RlRVU1VlFycHhwMWVOZ1JHcHZFNm9ablhBMVc2RzNjaHRsakFTYTNDQzBhYTI3MkFha1BECnl3VnZvcysvdVdNSGFmSEduL1dtNFMrQUxpKzltd2NGbGszdE9NS0RXTmlnSEdtV2U0SzFqTGlUUU1nVEhXUksKMk5YSFlZOEEzaVJrdkdmYkhzMXlIVDFYTGxsV1dqbDJYU204RFAveTdMaW1SbHFDUFo4Zyt2TUJwYUVuQmw5RwpEN3h3ZUF1Y3B1Z1FlcFBQdXpvc2tIRi9VVC9wMlZ2QkNzSFQzdFg5NHBLeVZaK1JYU1VYVlI1RTBzMHlwaDhyCllHMnUvTmVVUUE4N1QxWExONHdERXF2UXZIc0NBd0VBQWFOQ01FQXdEZ1lEVlIwUEFRSC9CQVFEQWdJRU1BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGQlBoTnRVdmV1b2ExOEtyNnE4WE9LS2FiRUhZTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQmdRQ1FyR1B1ODFHelBRRUV2SjNCWks3ZzFSSVZzaGxYLzI5V2hzQ0tXazU3CkVneFlVbkVESElvVmRuSFdUKzJNdVJoWk9uZG4wQURDOFQwaXBySE1TdGM3cnNOSSt4Qm1zQ3YvU0NPYWlLNEsKUGpnbk5qbm5kek1DazU0ZU1QZXM2dG04WHdNRm1ZeFBCcVk2aTdhOUlYenBwbXZQTVBDVVB2LzRiTVlmWlphVgpzV3JtTmw5Q05sWjQrczZZZHlxUXhxMVJWVmhJbjRMYkRtWS9pb3FwNk0zT1hvNFhJRzJTaUVaVXhLOEtXZmRMCmJBcnRpMEsrVkwzT1hTakNJWHZQTEpxTE02cjl3MFZNcFIrRUJBa3U2M093cVVubGZOYzh3S1hrVStVQkQ1VDQKTE5OTTliT04ySjMvNWt6c3p4ZFJwS1ZJVlU5Z0YvOUZYc0ZETWZsT09XS1o4VW1WL3czRW8xdis0VXBBMlFPWQpjU0sxcW0zSzdIZTkrY20zbW9EdWR5YmJPTFRFemJZZlRaaC9FMU9oRjE3eklGbXJHMTJsaFowWVhDR3dNTXgzCnlLWGcxY1FCNVgyeWRDdDNNNkY3MnJPVlpvdnNKMU9HaGdIbFRKZWhrbkV2TkRQWHQrcW9vOXVlZXdSaXBWVkcKS28rWnRJSGxaL0FPUXFadXd3WVI5b289Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
                    '''
                ) {
                    sh "kubectl get nodes"
                    sh "kubectl create deployment hema --image=caddy --replicas=3"
                    sh "kubectl get pods -o=wide"
                }
            }
        }
    }
}
```
### persistent volume 

* percistant volume connected to the cloud 
     
     these are 3 types of storage classes 

     (1). premium-rwo :

      when pod will be created only pvc is visable as binding other wise it shows waiting state.optimized for high-performance requirements.

     (2). standard: 

     when pvc created immediatly its attached to the pv its state shows  bounded. offers standard persistent disks on Google Cloud with immediate deletion when no longer needed, suitable for general-purpose storage needs.

     (3). standard-rwo (default) :
     
      this is also WaitForFirstConsumer when pod will be created only pvc is visable as binding other wise it shows waiting state. allowing a single node to read from and write to the persistent disk.

### Access modes in k8s 

    (1) ReadWriteOnce (RWO): copy and edit te text with in single node

    for example we can create replicas=3 , go to one pod in one node , we can create some fil and insert some data inside the file .
    we go to the another node we cannot get  modified files data .

    (2)ReadOnlyMany (ROX):copy the text in multiple nodes 

    (3)ReadWriteMany (RWX): for example we can create replicas=3 , go to one pod in one node , we can create some fil and insert some data inside the file .  check in another node also we get the same data.




