![one](https://github.com/ashrafulislamcs/flarie-tasks2/assets/78684586/84817749-90dc-4a54-9368-eba6ff3c0e1c)
![two](https://github.com/ashrafulislamcs/flarie-tasks2/assets/78684586/20078a4d-117c-40b1-8bcd-abf924c7f47a)


In the above architecture, I have worked from scratch as a single DevOps. 
This is a government project which is totally run on the on-baremetal server.
the project url is http://www.edp.gov.bd/

In this project, we have used private Gitlab and Private Docker Registry using Docker-Compose.
Jenkins for CI/CD, 
The backend stack is Java Spring Boot.
The frontend stack is React.
The database is Oracle Enterprise and MongoDB.
The caching Database is Redis.
The message broker is ActiveMQ.
For the storage and static file we have used NFS.
The monitoring stack is Grafana, Prometheus and the alert manager is Telegram.
The logs stack is Elasticsearch, Flentd, and kibana.
The DNS we have used is Cloudflare.
and the whole application is deployed in Kubernetes.
where for the sensitive credentials we have used secrets and for the URLs and some other data we have used configmap.
in this project, after modifying the two deployment files I have attached in this repo, where the manifest file I have mentioned secrets, configmap, storage, resources etc.




IaC codes for launching EKS Cluster
Installation and Configuration of the Cluster

Create an S3 bucket named 'terraform-state-store' from AWS Console and DynamoDB Table named 'terraform_locks' with key LockID and put the info in providers.tf file

Configure AWS CLI

$ aws configure

Go to the iac directory

$ cd iac

Initialize terraform in iac directory

$ terraform init

Plan the EKS cluster

$ terraform plan

Deploy the infra

$ terraform apply

When prompted for approval, type yes

Upon successful completion of cluster creation, now it's time for configuring the kubectl. Save the output in ~/.kube/config

$ terraform output kubeconfig >> ~/.kube/config
# Edit and trim the first and last line(containing <<EOT) from ~/.kube/config
$ vim ~/.kube/config
$ aws eks --region ap-southeast-1 update-kubeconfig --name eks-prod

Configure AWS config maps for accessing the nodes

$ terraform output config-map-aws-auth >> config-map-aws-auth.yaml
# Edit and trim the first and last line(containing <<EOT) from config-map-aws-auth.yaml
$ vim config-map-aws-auth.yaml
$ kubectl apply -f config-map-aws-auth.yaml

Now do kubectl get nodes -w to see the nodes coming up
Install AWS LB Controller for provisioning ingress with ALB

    Follow the instructions from https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html to provision LoadBalancer Controller

Check if the LB Controller is available by runnint kubectl get deployment -n kube-system aws-load-balancer-controller
How to use a Network Load Balancer with the NGINX Ingress resource in Kubernetes

Start by creating the mandatory resources for NGINX Ingress in your cluster:

$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/aws/deploy.yaml



Note: Currently I don't have an account in AWS so I could not try it on AWS,
But I have attached the some of terraform scripts in this repo, The scripts were collected from open-source and I have configured eks and some other services to follow these scripts. 
Basically, on 1st September of this Month, I was blessed with a baby girl. there was some complexity so the maximum time this week I was in the hospital to home and home to hospital. So that I could not concentrate on this task but the 7 days of time to submit this task is more than enough.
and next week I will be on paternity leave if you provide the AWS credential to complete task two from scratch in AWS using Terraform then I believe I'll be able to submit the next mentioned date.
