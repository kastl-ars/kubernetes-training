# GitOps with ArgoCD

The cluster has a working ArgoCD installation, which means you can start
creating `Application` CRs (custom resources, based on CRDs aka custom resource
definitions) to define your application.

## Adapt and create your application

Modify the `Application.yaml` file:

1. adjust the name for the application to have your username, i.e.
   `nginx-example-schulungXX`)
1. change the placeholder for the namespace (`YOUR_NAMESPACE_GOES_HERE`) to your
   actual namespace, i.e. `schulungXXwork`.

Create your application using `kubectl apply -f Application.yaml`.

## Check your application in the ArgoCD UI

Log into ArgoCD and check **your** application.

(As this is a demo cluster, there is only one user that can view and modify
everything, so please only work with your resources)

Delete a resource (deployment, service) via kubectl and check what happens in
the UI.

## Switching to your own repository

Fork the example repository (or create your own manually). Change the `repoURL`
in your `Application.yaml` and apply it using `kubectl apply`.

Start making modifications.

* What happens if you increase/decrease the number of replicas?
* What happens if you rename the service in `nginx-example/service.yml`?
* Add another directory called `busybox` in your ArgoCD repository and create
  another Application to use this directory
* ...
