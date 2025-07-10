# Quotas on namespaces

Assuming your namespace is empty, we can create a resource quota for that
namespace.

We start with a simple quota:

```yaml
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: simple-quota
spec:
  hard:
    pods: 2
```

## Create a simple quota

```
kubectl apply -f simple_resourcequota.yaml -n schulungXXwork
kubectl get resourcequota
NAME           AGE   REQUEST     LIMIT
simple-quota   5s    pods: 0/2
```

## Create deployments

We create a simple deployment with one pod and see what happens to our resource
quota.

```bash
$ kubectl apply -f deployment-with-one-replica.yaml
deployment.apps/deployment-with-one-replica created
$ kubectl get resourcequota
NAME           AGE   REQUEST     LIMIT
simple-quota   37s   pods: 1/2
```

So far, so good. Let's create another deployment with three replicas.

```
$ kubectl apply -f deployment-with-three-replicas.yaml
deployment.apps/deployment-with-ten-replicas created
$ kubectl get resourcequota
NAME           AGE   REQUEST     LIMIT
simple-quota   64s   pods: 2/2
$
```

Huh, only two pods? What is the state of our deployments?

```bash
$ kubectl get deploy
NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment-with-one-replica    1/1     1            1           45s
deployment-with-ten-replicas   1/3     1            1           18s
$
```

As you can see, our quota is working. Although we requested our deployment to
have three replicas, we only get one pod.

## Expanding on our quota

Next we can add some more restrictions to our quota. Or rather add another
resource quota.

The `example-quota` is imposing more restrictions upon our namespace, as you can
see:

```
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: example-quota
spec:
  hard:
    requests.memory: 100Mi
    requests.cpu: 1
    limits.memory: 200Mi
    pods: 3
    services: 1
    secrets: 1
    configmaps: 1
    persistentvolumeclaims: 1
    services.nodeports: 2
```

Let's apply it and check the status:

```bash
$ kubectl apply -f advanced_resourcequota.yaml
resourcequota/example-quota created
$ kubectl get resourcequota
NAME            AGE   REQUEST                                                                                                                                                      LIMIT
example-quota   4s    configmaps: 2/1, persistentvolumeclaims: 0/1, pods: 2/3, requests.cpu: 0/1, requests.memory: 0/100Mi, secrets: 4/1, services: 0/1, services.nodeports: 0/2   limits.memory: 0/200Mi
simple-quota    17m   pods: 2/2
$ kubectl get pods
NAME                                            READY   STATUS    RESTARTS   AGE
deployment-with-one-replica-5cdffb8544-cmk7v    1/1     Running   0          32s
deployment-with-ten-replicas-5cdffb8544-mbb7p   1/1     Running   0          29s
$
```

As can be seen, we have two resource quotas now. And we still have only two pods
running in our namespace, although the `example-quota` allows three pods.

Question: What happens if you delete the `simple-quota`?

## Tasks

* Create some configMaps, secrets and services in your namespace and check the
  behaviour during creation. What is different to the example above, when we
  created the deployments?
* Remove the deployments and create pods/deployments with CPU and memory
  requests and limits.
* Check the documentation on the meaning of `hard` in our quota.
* Check the documentation on other things you can constrain with a quota.
