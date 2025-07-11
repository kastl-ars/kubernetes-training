# Users in Containers

Create a persistent volume to keep our data.

```
kubectl apply -f pvc-security-context-demo.yml
```

## Container with uid 1000

Create a container running as UID 1000. Create a file in the path where the PV
is mounted:

```
kubectl apply -f pod_uid_1000.yml
kubectl exec -it pod/security-context-demo-1000 -- sh
~ $ ps
PID   USER     TIME  COMMAND
    1 1000      0:00 sleep 1h
    7 1000      0:00 sh
   13 1000      0:00 ps
~ $ id
uid=1000(1000) gid=3000(3000) groups=2000,3000(3000),4000
~ $ ls -lh /data/demo/
total 12K
drwxrws---    2 root     2000       12.0K Jul 11 10:31 lost+found
~ $ touch /data/demo/created_by_uid_1000.txt
~ $ ls -lh /data/demo/
total 12K
-rw-r--r--    1 1000     2000           0 Jul 11 10:32 created_by_uid_1000.txt
drwxrws---    2 root     2000       12.0K Jul 11 10:31 lost+found
~ $
```

As can be seen, the file belongs to the uid `1000` and the group `2000`, as
specified by the pod's specification:

```
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    supplementalGroups: [4000]
```

Make a mental note of the file's permissions!

## Container with uid 1001

Remove the first pod and create another one with UID 1001:

```
kubectl delete -f pod_uid_1000.yml
kubectl apply -f pod_uid_1001.yml
kubectl exec -it pod/security-context-demo-1001 -- sh
~ $ ps
PID   USER     TIME  COMMAND
    1 1001      0:00 sleep 1h
    7 1001      0:00 sh
   13 1001      0:00 ps
~ $ id
uid=1001(1001) gid=3000(3000) groups=2000,3000(3000),4000
~ $ ls -lah /data/demo/
total 13K
drwxrwsr-x    3 root     2000        1.0K Jul 11 10:32 .
drwxr-xr-x    3 root     root          18 Jul 11 10:36 ..
-rw-rw-r--    1 1000     2000           0 Jul 11 10:32 created_by_uid_1000.txt
drwxrws---    2 root     2000       12.0K Jul 11 10:31 lost+found
~ $ touch /data/demo/created_by_uid_1001.txt
~ $ ls -lah /data/demo/
total 13K
drwxrwsr-x    3 root     2000        1.0K Jul 11 10:37 .
drwxr-xr-x    3 root     root          18 Jul 11 10:36 ..
-rw-rw-r--    1 1000     2000           0 Jul 11 10:32 created_by_uid_1000.txt
-rw-r--r--    1 1001     2000           0 Jul 11 10:37 created_by_uid_1001.txt
drwxrws---    2 root     2000       12.0K Jul 11 10:31 lost+found
~ $
```

Check the permissions of both created files. Do you notice anything?

## Container with uid 1002

Create yet another pod, but this time without the `fsGroup` and
`supplementalGroups` settings.

```
kubectl delete -f pod_uid_1001.yml
kubectl apply -f pod_uid_1002.yml
kubectl exec -it pod/security-context-demo-1002 -- sh
~ $ id
uid=1002(1002) gid=3000(3000) groups=3000(3000)
~ $ ls -lah /data/demo
total 13K
drwxrwsr-x    3 root     2000        1.0K Jul 11 10:46 .
drwxr-xr-x    3 root     root          18 Jul 11 10:49 ..
-rw-rw-r--    1 1000     2000           0 Jul 11 10:44 created_by_uid_1000.txt
-rw-r--r--    1 1001     2000           0 Jul 11 10:46 created_by_uid_1001.txt
drwxrws---    2 root     2000       12.0K Jul 11 10:44 lost+found
~ $ touch /data/demo/created_by_uid_1002.txt
touch: /data/demo/created_by_uid_1002.txt: Permission denied
~ $ ~ $ ls -lah /data/
total 1K
drwxr-xr-x    3 root     root          18 Jul 11 10:49 .
dr-xr-xr-x    1 root     root          74 Jul 11 10:49 ..
drwxrwsr-x    3 root     2000        1.0K Jul 11 10:46 demo
~ $
```

Why does our container lack permissions to write to the PV?

## Encore

Remove everything, create the PVC and immediately create the pod with UID 1002.
What are the permissions of the `/data/demo/` directory? Can you create a file
there?
