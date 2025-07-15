# Bash completion for kubectl

Generate the completion file:

```
kubectl completion bash > ~/.kube/bash-completion
```

Add the following line to your `~/.bashrc`:

```
source ~/.kube/bash-completion
```

Run `source ~/.bashrc` and you should have working bash completion for
`kubectl`:

```
kubectl <TAB><TAB>
annotate          (Update the annotations on a resource)
api-resources     (Print the supported API resources on the server)
[...]
```
