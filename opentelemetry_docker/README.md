# Running OpenTelemetry in Docker/Podman

Replace `schulungXX` with your actual username.

## Create a docker network

```
docker network create opentelemetry-demo-schulungXX
```


## Run OpenTelemetry in the first terminal window

```
docker container run \
    --rm \
    --network opentelemetry-demo-schulungXX \
    --name otelcollector \
    -p 4317:4317 \
    -v "${PWD}"/config.yaml:/etc/otelcol-contrib/config.yaml \
    ghcr.io/open-telemetry/opentelemetry-collector-releases/opentelemetry-collector-contrib:latest
```

This blocks your terminal and shows the logs from the container.

## Run telemetrygen in a second terminal window

```
docker container run \
    --rm \
    --network opentelemetry-demo-schulungXX \
    ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest \
    traces --otlp-insecure --duration 5s --otlp-endpoint otelcollector:4317
```

Repeat the command and use `logs` or `metrics` instead of `traces`, and you will
send ... logs or metrics to the OpenTelemetry collector.

## Stop the otelcollector container

Stop the `otelcollector` container by pressing CTRL-C in the first terminal.

## Remove the network

Remove your network using `docker network rm opentelemetry-demo-schulungXX`.
