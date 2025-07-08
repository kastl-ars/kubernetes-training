# OpenTelemetry demo

## Prepare a serviceAccount with the right permissions

```
oc create sa opentelemetry-demo -n schulungXXwork
oc adm policy add-scc-to-user anyuid -z opentelemetry-demo -n schulungXXwork
```

## Install the demo application

Install the demo application using Helm. Please make sure to install it into
your own namespace, e.g. `schulungXXwork`.

```
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
helm install -f values.yaml --namespace schulungXXwork otel-demo open-telemetry/opentelemetry-demo
```

## Enable the port-forwarding

```bash
kubectl --namespace schulungXXwork port-forward svc/frontend-proxy 8080:8080
```

## Visit the web shop and play around

* Web store: <http://localhost:8080/>
* Grafana: <http://localhost:8080/grafana/>
* Load Generator UI: <http://localhost:8080/loadgen/>
* Jaeger UI: <http://localhost:8080/jaeger/ui/>
* Flagd configurator UI: <http://localhost:8080/feature>
