# Aliases

https://github.com/ahmetb/kubectl-aliases

## Manually

Add the following to your `~/.bashrc`, `~/.alias` or similar:

```
alias k='kubectl'
alias kaf='kubectl apply -f'
alias kd='kubectl describe'
alias kdf='kubectl delete -f'
alias kdno='kubectl describe nodes'
alias kdns='kubectl describe namespaces'
alias kdpo='kubectl describe pods'
alias kdrain='kubectl drain --delete-emptydir-data=true --ignore-daemonsets=true'
alias keit='kubectl exec -i -t'
alias kex='kubectl exec -i -t'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgd='kubectl get deploy'
alias kgi='kubectl get ingress'
alias kgno='kubectl get nodes'
alias kgns='kubectl get namespaces'
alias kgow='kubectl get -o=wide'
alias kgoy='kubectl get -o=yaml'
alias kgpo='kubectl get pods'
alias kgpoa='kubectl get pods -A'
alias kgpoaw='watch -n 2 kubectl get pods -A'
alias kgs='kubectl get service'
alias klo='kubectl logs'
alias klof='kubectl logs -f'
alias kp='kubectl proxy'
alias krm='kubectl delete'
alias krmpo='kubectl delete pods'
alias kcc='kubie ctx'
alias kccf='kubie ctx -f'
alias ns='kubie ns'
alias wkg='watch kubectl get'
```
