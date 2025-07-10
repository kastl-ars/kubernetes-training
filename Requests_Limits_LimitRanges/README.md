# Requests, limits and LimitRanges

* https://home.robusta.dev/blog/stop-using-cpu-limits


## Use a LimitRange to enforce request and limits being set

```bash
kubectl apply -f LimitRange.yaml
kubectl apply -f deployment.yaml
kubectl get deployment nginx-deployment -o yaml
kubectl get pods
kubectl get pods XXX -o yaml
```

**Questions**

* Did you notice any changes to the deployment?
* Did you find the request and limit settings in the pod's spec?

## Create a deployment that has requests and limits

What happens if we create a deployment that already sets requests and limits?

```bash
kubectl apply -f deployment-with-requests-and-limits.yaml
kubectl get pods
kubectl get pods XXX -o yaml
```

**Question**

* Which requests and limits are set on the pod?
