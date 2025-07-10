# Ingress and OpenShift Routes

## Ingress - the Kubernetes way

Ingress resources are supported by Kubernetes directly. They only provide basic
functionality: HTTP, HTTPS. That's it, mostly.

Depending on the ingress controller, you can enable/disable or configure aspects
of the ingress using annotations.

## OpenShift Routes

OpenShift uses routes instead of ingress resources. Or rather, routes are the
OpenShift-native way to make workloads reachable. If you create a Kubernetes
resource of type `Ingress`, OpenShift automatically creates a `Route` based on
your ingress definition. This way, all Kubernetes manifests or helm charts are
usable within OpenShift (in regards to ingress handling).

## Creating an ingress in Openshift

Please adjust the hostname in the ingress YAML file before applying it...

```yaml
[...]
spec:
  rules:
  - host: HOSTNAME_GOES_HERE
    http:
[...]
```

Then fire away:

```bash
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl apply -f ingress.yml
```

Trying to `curl` your hostname should work, but does not return any output?

```bash
$ curl HOSTNAME_GOES_HERE
$
```

Try again using `-v`:
```bash
$ curl -v HOSTNAME_GOES_HERE
* Connected to HOSTNAME_GOES_HERE (62.245.187.241) port 80
* using HTTP/1.x
> GET / HTTP/1.1
> Host: HOSTNAME_GOES_HERE
> User-Agent: curl/8.14.1
> Accept: */*
>
* Request completely sent off
< HTTP/1.1 302 Found
< content-length: 0
< location: https://HOSTNAME_GOES_HERE/
< cache-control: no-cache
<
* Connection #0 to host HOSTNAME_GOES_HERE left intact

$
```

As you can see, the ingress we created has automatically configured a HTTP
redirect from HTTP to HTTPS to enable TLS-encryption of the traffic, as is best
practice.

Run the `curl` command again, without the `-v` option, but run it against
`https://HOSTNAME_GOES_HERE`. What happens?

The part that configures the HTTP-to-HTTPS-redirect is the annotation:

```
metadata:
  name: nginx-ingress
  annotations:
    route.openshift.io/termination: edge
```

Remove the annotation from the ingress, deploy it again and run the `curl`
command again. What happens? What happens if you `curl` the https-URL?

## Using OpenShift Routes directly

When you created an Ingress, OpenShift automatically created a Route for you.

```bash
$ kubectl get ingress,route
NAME                                      CLASS    HOSTS                ADDRESS                    PORTS   AGE
ingress.networking.k8s.io/nginx-ingress   <none>   HOSTNAME_GOES_HERE   router-default.example.org 80      15m

NAME                                           HOST/PORT            PATH   SERVICES        PORT   TERMINATION   WILDCARD
route.route.openshift.io/nginx-ingress-fdq2g   HOSTNAME_GOES_HERE   /      nginx-service   http                 None
$
```

You can of course cut out the middle man and create the route yourself. Remove
the ingress, adjust the hostname in the `route.yaml` file and apply it. Try
using the curl command again.
