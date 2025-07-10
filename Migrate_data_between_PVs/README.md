# Migrate data between PVs

* create two PVCs
* create the service and the ingress, as usual
* create a deployment using one of the PVCs
* `exec` into the pod and put a file into the PV
  * or use `kubectl cp` to copy it to `/usr/share/nginx/html/index.html`
* run `curl` to see your new shiny index.html
* delete the deployment (or scale down to 0 replicas)
* copy the file between the PVs

  ```
  pv-migrate migrate --ignore-mounted --no-chown --strategies mnt2 --helm-set rsync.extraArgs="--omit-dir-times" pvc1 pvc2

  ```

* delete the first PV
* modify the deployment to use the second PVC
* `exec` into the pod and check that your file is still present
