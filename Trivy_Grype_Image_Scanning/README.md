# Image scanning with trivy and grype

Security is a big topic.

```
<insert long talk about importance of secure container images here>
```

## Scanning a container image with trivy

Compare the output of the following commands:

```bash
trivy image python:3.13-alpine
```

```bash
trivy image cgr.dev/chainguard/python:latest
```

## Scanning container images with grype

Compare the output of the following commands:

```bash
grype python:3.13-alpine
```

```bash
grype cgr.dev/chainguard/python:latest
```

## Tasks

* Check the images that were used in the exercises this far
* Check if there are distroless or Chainguard alternatives
