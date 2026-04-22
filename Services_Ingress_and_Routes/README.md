# Services, Ingresses and Routes

Create the deployment and the service from the YAML files of the same names.

Run `kubectl get` and `kubectl describe` on the service.

You should be able to `curl` your service from another pod. You know how, right?

Modify the `ingress.yml` file and replace `XX` with your number (the one in your
username). Create the ingress, check its state using `kubectl describe` and try
to curl the URL.

- `curl http://...`
- `curl -kL http://...`
- `curl https://...`
- `curl -k https://...`

(You can of course also use `curl -I ...|head -n 1` or similar, you only need to
make sure you noticed the difference between working and non-working
requests...)

(FYI, `-k` ignores TLS certificate errors, as the training cluster might not
have valid TLS certificates)
