# Deployment Strategies

This exercise simulates a new version of an application being released. And how
we can deal with the update process, to avoid downtime of our application.

## Create the "old" deployment

```bash
kubectl apply -f old_deployment.yaml
kubectl get pods
```

## Update the deployment

Run the following command in on terminal window (or tmux pane or screen or ...).

```bash
watch kubectl get pods
```

In an second window/pane/..., run the following command and monitor what happens
in the first window/pane/...:

```bash
kubectl apply -f new_deployment.yaml
```

## Switch to the Recreate strategy

* Remove the deployment
* Modify both YAML files to use the `Recreate` strategy
  * [documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)
* create the "old" deployment
* update the deployment and watch what happens
