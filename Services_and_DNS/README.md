# Services and DNS

Create the deployment and the service from the YAML files of the same names.

Run `kubectl get` and `kubectl describe` on the service.

Get your pods IP address, `exec` into the alpine pod in your
`schulungXXhome` namespace and curl your pod:

```bash
$ kubectl exec -ti alpine-deployment-5c4cfc6786-8gsjk -n schulungXXhome -- sh
~ $ curl --silent -I 10.129.4.15:8080 | head -1
HTTP/1.1 200 OK
~ $
```

The pod itself is listening on port 8080, so you need to `curl` using that port
number.

From the `kubectl describe` you can see that the service listens on port 80, but
has port 8080 as the target port. Run `curl` against the service's IP address.

```
~ $ curl --silent -I 172.30.236.126 | head -1
HTTP/1.1 200 OK
~ $
```

This also works. Now to the fun part: DNS.

Run curl against the following URLs:

* `nginx-service`
* `nginx-service.schulungXXwork`
* `nginx-service.schulungXXwork.svc`
* `nginx-service.schulungXXwork.svc.cluster`
* `nginx-service.schulungXXwork.svc.cluster.local`

(If a command takes to long, abort it using CTRL+C).

What happened? Which URLs worked?
