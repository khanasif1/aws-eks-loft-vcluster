helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update



helm install nginx-ingress --create-namespace -n nginx-ingress ingress-nginx/ingress-nginx --set "controller.extraArgs.enable-ssl-passthrough=false"

kubectl get service -n nginx-ingress | grep LoadBalancer | awk {'print $4'}


#https://cert-manager.io/docs/installation/ 
# kubectl apply  -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml
# kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml

# kubectl apply -f ./ingress/cluster-issuer.yaml

# Following video https://www.youtube.com/watch?v=gvKi7wZHbLU&list=WL&index=2&t=1481s
    kubectl create namespace demo-vcluster

    k create -f ingress-nginx-deploy.yaml   

    k get all -n ingress-nginx  

    kubectl  apply -f ./app/product/product.yaml
    k expose deployment product -n demo-vcluster  --type=LoadBalancer --port=80

    kubectl apply -f ./ingress/ingress.yaml

    k get ingress -n demo-vcluster

    k describe ingress -n demo-vcluster  

    k edit svc product -n demo-vcluster 
 




 vcluster create demo-vcluster --namespace demo-vcluster  --connect=false  -f vclusterconfig.yaml

 

 vcluster connect demo-vcluster --update-current=false --server=http://akaasif.people.aws.dev # https://demo.vcluster-demo.com  

vcluster connect demo-vcluster -n demo-vcluster --update-current=false --server=https://3.25.205.126


 k --kubeconfig ./kubeconfig.yaml get ns


vcluster delete demo-vcluster -n demo-vcluster   --delete-namespace
kubectl delete all  --all -n ingress-nginx
k delete ns ingress-nginx  
k delete clusterrole ingress-nginx
k delete clusterrole ingress-nginx
k delete clusterrole nginx-ingress-ingress-nginx
k delete clusterrole ingress-nginx-admission
k delete clusterrolebindings ingress-nginx
k delete clusterrolebindings ingress-nginx-admission
k delete clusterrolebindings nginx-ingress-ingress-nginx
k delete ingressclasses nginx
k delete validatingwebhookconfigurations ingress-nginx-admission
k delete validatingwebhookconfigurations  nginx-ingress-ingress-nginx-admission

##Isolation using --expose -- NOT WORKING

    vcluster create isolated-vcluster --namespace isolated-vcluster --connect=false --expose  --isolate=true
    vcluster connect demo-vcluster --update-current=false

    vcluster delete isolated-vcluster -n vcluster-isolated-vcluster   --delete-namespace
    vcluster delete demo-vcluster -n vcluster-demo-vcluster   --delete-namespace

##Isolation using Via NodePort service -- NOT WORKING https://www.vcluster.com/docs/using-vclusters/access  

    kubectl create namespace demo-vcluster

    kubectl apply -f ./ingress/nodeport.yaml

    kubectl get svc vcluster-nodeport -n demo-vcluster

    kubectl get nodes -o wide

    vcluster create demo-vcluster --namespace demo-vcluster  --connect=false  -f np-vclusterconfig.yaml

    vcluster connect demo-vcluster -n demo-vcluster --update-current=false --server=https://3.25.205.126

    k --kubeconfig ./kubeconfig.yaml get ns

    vcluster disconnect --context  {context string from .kubeconfig}

    vcluster delete demo-vcluster -n demo-vcluster   --delete-namespace


# testing sample from https://loft.sh/blog/aws-eks-multi-tenancy-with-vcluster/ -- NOT WORKING
        vcluster create sales -f  ./ingress/cluster-sale.yaml
        vcluster create product -f  ./ingress/cluster-product.yaml


        vcluster connect sales --update-current=false

        vcluster connect product --update-current=false

        k --kubeconfig ./kubeconfig.yaml  create namespace app-product
        k --kubeconfig ./kubeconfig.yaml  create namespace app-sale

        kubectl  --kubeconfig ./kubeconfig.yaml apply -f product.yaml

        kubectl  --kubeconfig ./kubeconfig.yaml apply -f sale.yaml


        k --kubeconfig ./kubeconfig.yaml exec --stdin --tty product-7695d46444-rbhws -n app-product -- /bin/bash

        product service - http://10.100.244.100/ping


        k --kubeconfig ./kubeconfig.yaml exec --stdin --tty sale-5fd77b9449-z2n8p -n app-sale -- /bin/bash

        sale service  - http://10.100.201.248/ping


        vcluster delete product -n vcluster-product   --delete-namespace
        vcluster delete sales -n vcluster-sales   --delete-namespace