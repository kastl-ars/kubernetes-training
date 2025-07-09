# StatefulSets

[Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)

* create a statefulset using Nginx and a pvcTemplate
* `exec` into the pod and write the pods number into the PV
* scale up your statefulset to 3 pods
* `exec` into the pod and write the pods number into the PV
* remove the second pod
* check the correct number in the PV of the newly created second pod
* check the documentation for the DNS naming scheme for pods in statefulsets
* scale down your statefulset and watch, which pods are being terminated
* ...
