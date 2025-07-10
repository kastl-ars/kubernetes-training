# Ephemeral Volumes

* Create a Nginx pod and mount a `emptyDir` to `/usr/share/nginx/html`.
* What happens if you `curl` the pod's IP address from another pod?
* What happens if you `exec` into the pod and try to create an `index.html`
  inside that directory?
