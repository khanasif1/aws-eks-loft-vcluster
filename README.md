# aws-eks-loft-vcluster


K8S Cheat
=========

To view your current context:

$ kubectl config current-context

To list all your contexts:

$ kubectl config get-contexts

To create a new context:

$ kubectl config set-context fm-context --namespace=default  --cluster=my-cluster --user=fm

To switch to a different context:

$ kubectl config use-context my-context

