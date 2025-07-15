# Show Kubernetes information in your bash prompt

Download the file from the GitHub repository:

```
cd ~/.kube/
wget https://raw.githubusercontent.com/jonmosco/kube-ps1/refs/heads/master/kube-ps1.sh
```

Add the following lines to your `~/.bashrc`:

```
source ~/.kube/kube-ps1.sh
PS1='$(kube_ps1) \w \$ '
```

Open a new shell or run `source ~/.bashrc` in your current shell, and you should
see a new prompt...
