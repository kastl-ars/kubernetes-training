# Validating Admission Policy

Documentation: <https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/>

1. Apply the `ValidatingAdmissionPolicy`:

   ```
   kubectl apply -f Replicas_ValidatingAdmissionPolicy.yaml
   ```

1. Apply the `ValidatingAdmissionPolicyBinding`:

   ```
   kubectl apply -f Replicas_ValidatingAdmissionPolicyBinding.yaml
   ```

1. Try to create a deployment with 1 replica, which will succeed:

   ```
   kubectl apply -f deployment-with-one-replica.yaml -n default
   ```

1. Try to create a deployment with 10 replicas, which will fail:

   ```
   kubectl apply -f deployment-with-ten-replicas.yaml -n default
   ```

1. Try to create a deployment with 10 replicas in another namespace, which will
   succeed:

   ```
   kubectl apply -f deployment-with-ten-replicas.yaml -n <other-namespace>
   ```
