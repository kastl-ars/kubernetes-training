# Network Policies

## Prepare the nginx deployment

As usual, replace `schulungXXwork` with your actual namespace.

```
kubectl apply -f nginx-deployment.yml -n schulungXXwork
```

## Check from a pod in the same namespace

```bash
$ kubectl get pods -o wide -n schulungXXwork
NAME                                READY   STATUS    RESTARTS   AGE     IP             NODE        NOMINATED NODE   READINESS GATES
nginx-deployment-5cdffb8544-kgpf7   1/1     Running   0          3m32s   10.129.5.87    worker-03   <none>           <none>
nginx-deployment-5cdffb8544-r8t7c   1/1     Running   0          3m32s   10.131.0.195   worker-02   <none>           <none>

# connect to the first pod
$ kubectl exec -ti nginx-deployment-5cdffb8544-kgpf7 -- bash
# run curl against the IP of the second pod
/$ curl 10.131.0.195:8080
!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
[...]
/$ exit
$
```

## Apply a network policy and test again

The first network policy forbids all ingress traffic, even from pods in the same
namespace.

```
$ kubectl apply -f Networkpolicy_denied.yml
# connect to the first pod
$ kubectl exec -ti nginx-deployment-5cdffb8544-kgpf7 -- bash
# run curl against the IP of the second pod
/$ curl 10.131.0.195:8080
[... runs into a timeout ...]
# run curl against a website, to check that egress traffic is still allowed
/$ curl --silent -I kubernetes.io | head -1
HTTP/1.1 301 Moved Permanently
/$ exit
$ kubectl delete -f Networkpolicy_denied.yml
```

## Apply a network policy allowing pod-to-pod ingress traffic

This network policy allows ingress traffic from other pods having the `app:
nginx` label.

```bash
$ cat Networkpolicy_allow_other_nginx_pods.yml
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: nginx-allow-other-nginx-pods
spec:
  podSelector: {}
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: nginx
```

Let's see it in action.

```
$ kubectl apply -f Networkpolicy_allow_other_nginx_pods.yml
# connect to the first pod
$ kubectl exec -ti nginx-deployment-5cdffb8544-kgpf7 -- bash
# run curl against the IP of the second pod
/$ curl 10.131.0.195:8080
!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
[...]
# run curl against a website, to check that egress traffic is still allowed
/$ curl --silent -I kubernetes.io | head -1
HTTP/1.1 301 Moved Permanently
/$ exit
$ kubectl delete -f Networkpolicy_denied.yml
```

## Check from a pod in another namespace

To make sure our network policy is watertight, we check from a pod in another
namespace.

```
$ kubectl get pods -n schulungXXhome
NAME                                 READY   STATUS    RESTARTS   AGE
alpine-deployment-5c4cfc6786-8gsjk   1/1     Running   0          23d
$ kubectl exec -ti alpine-deployment-5c4cfc6786-8gsjk -n schulungXXhome -- sh
~ $ curl 10.131.0.195:8080
[... runs into a timeout ...]
~ $ exit
$
```

## Check from an nginx pod in another namespace

The network policy allows ingress to all pods in our namespace that have the
`app: nginx` label. But this only allows pods **in the same namespace**.

To prove that, create yet another nginx deployment in the `schulungXXhome`
namespace and try the `curl` command again.

```
$ kubectl apply -f nginx-deployment.yml -n schulungXXhome
$ kubectl get pods -n schulungXXhome
$ kubectl exec -ti nginx-... -n schulungXXhome -- bash
/$ curl 10.131.0.195:8080
[... runs into a timeout ...]
/$ exit
```
