# nodeAffinity

In case you want to run pods only on special nodes, e.g. those having a GPU for machine learning, you can use nodeAffinity.

## 1. Label your worker nodes with different colors

```
kubectl label node WORKER_NODE_1 color=red
kubectl label node WORKER_NODE_2 color=green
kubectl label node WORKER_NODE_3 color=blue
```

Check the labels on all workers:

```
kubectl get nodes --show-labels|grep color
```

## 2. Create deployment and test if it's working

Create two deployments that use nodeAffinity and check, on which node the pods
are being scheduled.

```
kubectl apply -f deployment_blue.yml
kubectl apply -f deployment_yellow.yml
kubectl get pods -o wide
```
