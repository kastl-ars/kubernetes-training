# RBAC

## Create the serviceAccount and prepare the KUBECONFIG

```bash
kubectl config current-context
# rename your current context to `dmz`
kubectl create serviceaccount demo-user
TOKEN=$(kubectl create token demo-user)
kubectl config set-credentials demo-user --token=$TOKEN
kubectl config set-context demo-user-context --cluster="api-dmz-kurs-ars-computer-de:6443" --user=demo-user --namespace=schulungXXwork # adjust to your namespace
kubectl config current-context
kubectl config use-context demo-user-context
kubectl get pods
```

At this point the serviceAccount is used to talk to the cluster, but is
forbidden from listing pods.

## Create a role and rolebinding for the serviceAccount

```bash
kubectl config use-context dmz
kubectl apply -f role-demo.yml
kubectl apply -f rolebinding-demo.yml
kubectl config use-context demo-user-context
kubectl get pods
```
