##  Install the vCluster CLI
```

curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-darwin-arm64" && sudo install -c -m 0755 vcluster /usr/local/bin && rm -f vcluster

```
```
vcluster --version
```


##  Create your virtual cluster

```
vcluster create product-cluster --namespace v-product  --connect=false  --isolate=true


vcluster create sale-cluster --namespace v-sale  --connect=false  --isolate=false
```
## Connect

cd <path>/aws-eks-loft-vcluster/app/product/cluster-config

<!-- below command will connect to product-cluster and add ./kubeconfig.yaml to folder -->
vcluster connect product-cluster -n v-product --update-current=false 

vcluster connect sale-cluster -n v-sale --update-current=false 


kubectl  --kubeconfig ./kubeconfig.yaml get namespaces



kubectl  --kubeconfig ./kubeconfig.yaml create namespace app-product
kubectl  --kubeconfig ./kubeconfig.yaml create namespace app-sales

vcluster connect product-cluster -n v-product --update-current=false 


vcluster create product-cluster --namespace v-product --upgrade  --connect=false  --isolate=true

vcluster pause product-cluster -n v-product
vcluster resume product-cluster -n v-product

vcluster create sale-cluster --namespace v-sale --upgrade  --connect=false  --isolate=true

vcluster pause sale-cluster -n v-sale
vcluster resume sale-cluster -n v-sale


## Deploy app
kubectl  --kubeconfig ./kubeconfig.yaml apply -f ../../../vcluster/deployment/app/product.yaml
kubectl  --kubeconfig ./kubeconfig.yaml apply -f ../../../vcluster/deployment/app/sale.yaml
- ssh on container
    kubectl exec --stdin --tty {podname} -- /bin/bash

     k --kubeconfig ./kubeconfig.yaml exec --stdin --tty product-56c4ccf957-cs478 -n app-product -- /bin/bash
     k --kubeconfig ./kubeconfig.yaml exec --stdin --tty sale-b5b866585-qfwtg -n app-sales -- /bin/bash

- check api
    curl http://localhost/ping
    curl http://localhost/list


```
- Use `vcluster disconnect` to return to your previous kube context
```


## vcluster create has config options for specific cases:

    Use --expose to create a vCluster in a remote cluster with an externally accessible LoadBalancer.

    vcluster create my-vcluster --expose

    Use -f to use an additional Helm values.yaml with extra chart options to deploy vCluster.

    vcluster create my-vcluster -f values.yaml

    Use --distro to specify either k0s or vanilla k8s as a backing virtual cluster.

    vcluster create my-vcluster --distro k8s

    Use --isolate to create an isolated environment for the vCluster workloads

    vcluster create my-vcluster --isolate

##  List vCluster
vcluster list

##  vCluster Delete
vcluster delete product-cluster -n v-product   --delete-namespace
vcluster delete sale-cluster -n v-sale   --delete-namespace
