# PodDisruptionBudget

- Create the nginx deployment using the `nginx-deployment.yml` file
- Create the PodDisruptionBudget using the `PodDisruptionBudget.yml` file
- Scale the application to 1 replica, what happens?
- Scale the application back to 3 replicas
- Evict a pod using `kubectl evict-pod nginx-deployment-...?
- Modify the PDB to require 3 available pods at all times
- Evict a pod using `kubectl evict-pod nginx-deployment-...?
