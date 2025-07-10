# Copying files from and to containers

## Create a deployment and an ingress

Modify the `ingress.yml` file before applying to enter your hostname.

```
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl apply -f ingress.yml
```

When you try to reach your ingress's URL, you get an error:

```

$ curl HOSTNAME_GOES_HERE
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.23.4</center>
</body>
</html>
$
```

The reason is that the deployment mounts an `emptyDir` to `/usr/share/nginx/html/`, where nginx expects to find its `index.html`.

(Of course this is a made-up example, but you get the idea.)

## Create a index.html and copy it into the container

```bash
kubectl get pods
echo "Hello there" > index.html
kubectl cp index.html nginx-deployment-dbd5bd6cf-d22qv:/usr/share/nginx/html/
```

Now try running the `curl` command again:

```bash
$ curl HOSTNAME_GOES_HERE
Hello there
$
```

(This only works, because a `emtpyDir` mount is writable by the container. In most cases, you get a `Permission denied` error...)

## Copying a file from a container

To copy a file from a container to your host, run a command such as:

```bash
kubectl cp nginx-deployment-dbd5bd6cf-d22qv:/etc/nginx/conf.d/default.conf default.conf
```

Note: If you try to use a dot `.` instead of the local file name `default.conf`, to copy the file into the current working directory, this will fail:

```bash
$ kubectl cp nginx-deployment-dbd5bd6cf-d22qv:/etc/nginx/conf.d/default.conf .
tar: Removing leading `/' from member names
error: open .: is a directory
$
```

## Copying directories recursively

To copy a directory to or from a container, just specify the directory's name:

```
$ kubectl cp nginx-deployment-dbd5bd6cf-d22qv:/etc/nginx ./nginx/
$ ls -1 ./nginx/
conf.d
fastcgi_params
mime.types
nginx.conf
scgi_params
uwsgi_params
$
```
