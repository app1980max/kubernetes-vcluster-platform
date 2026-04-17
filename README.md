<img width="1150" height="642" alt="image" src="https://github.com/user-attachments/assets/30974ed5-52e1-4689-b8a4-78ba353e1fff" />



## vCluster Platform | Multiple Virtual Clusters
vCluster is an open source solution that enables teams to run virtual Kubernetes clusters inside existing infrastructure. It helps platform engineers create secure, isolated environments for development, testing, CI/CD, and even production workloads, without the cost or overhead of managing separate physical clusters.


🧠 Core Idea:
```
✅ Run multiple virtual clusters (vClusters) inside one real cluster
✅ Each team/user gets their own isolated environment
✅ All managed from one platform UI/API
```


🏗️ Key Components
```
1. Virtual Clusters
2. Platform (Control Plane)
3. Projects & Access Control
4. Apps Layer
5. Cost Optimization Features
```


🚀 Deployment Options
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```



🏗️ How to connect:
```
vcluster list
vcluster connect vcluster-dev -n vcluster-dev
vcluster connect vcluster-dev -n vcluster-test

vcluster upgrade
vcluster login vcluster-dev.appflex.io --access-key KRpaVnXKSA9jGDE6mX43j3jhsjkhjskhjskhshjssk
vcluster platform add vcluster vcluster-dev  --project=default
vcluster platform add vcluster vcluster-qa   --project=default

kubectl config get-contexts
kubectl config use-context kind-dev-cluster
kubectl config use-context vcluster_vcluster-dev_vcluster-dev_kind-dev-cluster
```

