# StatefulSets and DNS

- [Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id)
- [Documentation headless services](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)

Create the StatefulSet and create a headless service.

Headless services are services with the `clusterIP` set to `None` (which is not
the same as not setting it...).

Important: The service's name MUST match the name in the `StatefulSet`'s
`.spec.serviceName` field.

```yaml
apiVersion: apps/v1
kind: StatefulSet
[...]
spec:
  serviceName: foo
[...]
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: foo
spec:
[...]
```
