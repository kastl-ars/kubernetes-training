# Helm Basics

## First installation

* Create a new helm chart using `helm create yournamehere`
* remove the `template/tests/` directory
* adjust the `Chart.yaml`
* run `helm dependency build`
* run `helm template foo .` (either `.` or the full or relative path to your
  `yourname` directory)
* find out the right `--set` command to change the number of replicas to two
* install the chart using `helm install foo .` (either `.` or the full or
  relative path to your `yourname` directory)
  * you'll notice the pods are crashing (`CrashLoopBackOff`)

## Upgrading your chart installation

* upgrade without changes using `helm upgrade foo ...`
* change the number of replicas in the chart's `values.yaml` file to `2`
* upgrade your `foo` release
* check for helm releases with `helm ls`

## Rolling back

* check your helm release's history with `helm history foo`
* rollback to the first revision using `helm rollback ...` (side quest: how to
  find out the right parameters for this command?)

## `--set` vs. your own file containing your settings

* create a `meinewerte.yaml` file and add the equivalent of your `--set`
  parameter above
* run `helm upgrade foo -f meinewerte.yaml ...` (without the `--set`)

## Getting the pods running

* change the image in the chart to the one used in other exercises
* upgrade and notice the pods are still crashing
* adjust the chart to the new image (hint: ports)
* upgrade and notice the pods are now running fine

## Getting the ingress working

* find out how to set the ingress hostname to
  `nginxXX.apps.dmz-kurs.ars-computer.de` (using your user's number instead of
  the `XX`)
* try to find the right settings to enable the ingress
* try to adjust your chart so the ingress is working with the new image
* Run `curl -skIL ... | head -n 1` against your ingress to check if it is working
  (or use your browser, ignoring the self-signed certificate)

## ConfigMaps

* Add a configMap to your chart and adjust the deployment, to mount only the
  `index.html` key to `/usr/share/nginx/html/index.html`
* Make sure the deployment is being updated, when the configMap is modified

  [Helm documentation](https://helm.sh/docs/howto/charts_tips_and_tricks/#automatically-roll-deployments)

## Dependencies

* Add a dependency to your chart
* make your dependency optional,  i.e. use `condition`
* make sure your optional dependency is not installed by default
* Set some parameters for your dependency chart
  - set the number of replicas for your dependency chart
* run `helm template foo .`, what happens now?
