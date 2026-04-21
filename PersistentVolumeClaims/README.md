# PersistentVolumeClaims and PersistentVolumes

[Kubernetes documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#claims-as-volumes)

## Creating a `PersistentVolume` by using a `PersistentVolumeClaim`

* Create a PVC matching a `storageClass` in your cluster
  * `kubectl get sc` gives you the existing `storageClasses`
* Check for a matching `persistentVolume`
  * in case there is none, what is the status of your PVC?
  * in case there a PV, what is the status of your PVC?

## Wrong path for volume

* Create an Nginx pod following the documentation
* `exec` into the pod and run a `curl localhost`
* Overwrite the `index.html`

  ```bash
  echo "Hello from Kubernetes" > /usr/share/nginx/html/index.html
  ```

* `exec` into the pod and run a `curl localhost`
* Delete the pod and create it again, using the same PVC
* `exec` into the pod and run a `curl localhost`

## Correct path

Do the same as above, but use `/usr/share/nginx/html/` as the path for the
`volumeMount`.
