# kustomize

## Usage

Although there is a separate binary called `kustomize`, the functionality is
also available in the `kubectl` or `oc` command. `kubectl kustomize
/path/to/directory/` will evaluate the files in your `/path/to/directory/`
directory as kustomize files.
When applying them to the cluster, use the `-k` flag for the `kubectl apply` or
`oc apply` commands and give it the directory path as argument.

```
kubectl apply -k /path/to/directory/
# or
oc apply -k /path/to/directory/
```

## Development deployment

Create the development deployment in your `schulungXXwork` namespace.

```
cd base
# check the output
kubectl kustomize .
# create the development deployment
kubectl apply -n schulungXXwork -k .
```

As defined in the files in `base`, we have one replica running.

```
$ kubectl get pods -o wide -n schulungXXwork
[...]
$ kubectl exec -it  alpine-deployment-5c4cfc6786-8gsjk -n schulungXXhome -- sh
~ $ curl 10.129.6.122:8080
Hello from development
~ $ exit
$
```

As can be seen, the `curl` command results in a `Hello from development`
message.

## Production deployment

For our production deployment, we want to have more replicas. And we want an
`index.html` stating that we have a production deployment.

The files in the `overlays/production/` directory accomplish that.

```
cd overlays/production/
# check the output
kubectl kustomize .
# create the production deployment
kubectl apply -n schulungXXwork -k .
```

Check again from the `alpine` pod in the `schulungXXhome` namespace:

```
$ kubectl get pods -o wide -n schulungXXwork
[...]
$ kubectl exec -it  alpine-deployment-5c4cfc6786-8gsjk -n schulungXXhome -- sh
~ $ curl 10.129.6.222:8080
THIS IS PRODUCTION!
~ $ exit
$
```

## Exercise

To be safe, we do not want to use the `latest` version of the image in
production. Add a patch to the `overlays/production/` directory to change the
tag to the "one before latest".

## Homework

Your boss tells you to add another stage between `development` and `production`,
called `qa`. He wants to have 3 replicas and an `index.html` adapted to QA.
