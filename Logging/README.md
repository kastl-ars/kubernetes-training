# Logging

# Single pod with a single container

Having only one container in a pod, it is easy to get the logs.

```
$ kubectl apply -f single-pod-single-container.yaml
$ kubectl get pods
$ kubectl logs -f single-pod-single-container
0: Thu Jul 10 08:22:03 UTC 2025
1: Thu Jul 10 08:22:04 UTC 2025
2: Thu Jul 10 08:22:05 UTC 2025
3: Thu Jul 10 08:22:06 UTC 2025
4: Thu Jul 10 08:22:07 UTC 2025
5: Thu Jul 10 08:22:08 UTC 2025
[...]
$
```

## Single pod with multiple containers

Having more than one container in a pod, it is a little more tricky to get each
container's logs. Doable with `kubectl logs`, but with limitations.

```
$ kubectl apply -f single-pod-multiple-containers.yaml
$ kubectl get pods
$ kubectl logs single-pod-multiple-containers
Defaulted container "container1" out of: container1, container2, container3, container4
container1 - 0: Thu Jul 10 08:10:32 UTC 2025
container1 - 1: Thu Jul 10 08:10:33 UTC 2025
container1 - 2: Thu Jul 10 08:10:34 UTC 2025
[...]
$ kubectl logs single-pod-multiple-containers -c container2
container2 - 0: Thu Jul 10 08:10:33 UTC 2025
container2 - 1: Thu Jul 10 08:10:34 UTC 2025
container2 - 2: Thu Jul 10 08:10:35 UTC 2025
[...]
```

## Getting logs from multiple pods with stern

https://github.com/stern/stern

```
$ stern single-pod-multiple-containers
[...]
single-pod-multiple-containers container2 container2 - 14: Thu Jul 10 08:10:47 UTC 2025
single-pod-multiple-containers container4 container4 - 11: Thu Jul 10 08:10:47 UTC 2025
single-pod-multiple-containers container1 container1 - 16: Thu Jul 10 08:10:48 UTC 2025
single-pod-multiple-containers container3 container3 - 13: Thu Jul 10 08:10:48 UTC 2025
single-pod-multiple-containers container2 container2 - 15: Thu Jul 10 08:10:48 UTC 2025
single-pod-multiple-containers container4 container4 - 12: Thu Jul 10 08:10:48 UTC 2025
single-pod-multiple-containers container1 container1 - 17: Thu Jul 10 08:10:49 UTC 2025
single-pod-multiple-containers container3 container3 - 14: Thu Jul 10 08:10:49 UTC 2025
[...]
```
