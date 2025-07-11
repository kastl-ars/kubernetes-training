# Debugging containers

Easy. `kubectl exec` and you are in business. Right?

No. At least not with all containers. What if the container image does not
include the tool you need? `ping`? `curl`? `tcpdump`?

What if it does not include a shell at all, but is a scratch or distroless
image?

Enter `kubectl debug` and `cdebug`.

## Debugging using kubectl debug

For some container images, `kubectl debug` is working perfectly fine:

```
kubectl run nginx-pod --image nginx
kubectl debug -it nginx-pod --image alpine --target nginx-pod
/ # ps
/ # cat /etc/os-release
/ # cat /proc/1/root/etc/os-release
/ # cat /proc/1/root/usr/share/nginx/html/index.html
```

For others it isn't:

```
kubectl run nginx-distroless --image cgr.dev/chainguard/nginx
kubectl debug -it nginx-distroless --image alpine --target nginx-distroless
/ # cat /proc/1/root/etc/os-release
cat: can't open '/proc/1/root/etc/os-release': Permission denied
/ # whoami
root
```

Even though we are working as the `root` user in the container, we are lacking
permissions. This is caused by the `nginx-distroless` container being run with
another UID.

We could build a container image ourselves and change the `USER` to this UID. Or
we use the `-dev` container image from Chainguard, which has a shell **AND**
runs as this user.

```
$ kubectl debug -it nginx-distroless --image cgr.dev/chainguard/nginx:latest-dev --target nginx-distroless -- /bin/sh
/ # cat /proc/1/root/etc/os-release
ID=wolfi
NAME="Wolfi"
[...]
```

There is also a tool called `cdebug` that is able to do some of the heavy
lifting. It is also able to set a user, a functionality which `kubectl debug` is
lacking.

## Thanks

Big thanks to Ivan Velichko and Adrian Mouat for digging deep into this.

* https://dev.to/chainguard/debugging-distroless-images-with-kubectl-and-cdebug-1dm0
* https://iximiuz.com/en/posts/docker-debug-slim-containers/
