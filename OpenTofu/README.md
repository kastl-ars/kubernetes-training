# Kubernetes and OpenTofu/Terraform

You can manage Kubernetes resources via OpenTofu/Terraform, if you want to. This
directory contains some sample code to get you started.

## Prepare a `terraform.tfvars` file

Copy the `terraform.tfvars.example` file to `terraform.tfvars` and adjust its
content:

* namespace and ingress hostname
* Kubernetes API URL
* Token from your kubeconfig file

## Initialize, validate and plan

OpenTofu is installed on our jumphost VM. If you want to work from your laptop,
there are many ways to install it (check the OpenTofu homepage).

Before you can use OpenTofu to manage k8s resources, you need to initialize the
directory, to make sure all required "providers" are present.

```
tofu init
```

To make sure your configuration is valid, you can run `tofu validate`. If no
errors are found, you can run `tofu plan` to check, what OpenTofu would do. This
command can be run at all times and compares the actual state with the desired
state, as defined by your code.

## Create resources with `tofu apply`

Run `tofu apply` to create your Kubernetes resources. This runs a plan first and
asks you for your confirmation. Type in `yes`, hit Enter and watch OpenTofu
create a deployment, a service and an ingress.

Try running `curl` against the ingress hostname.

## Clean up your resources

As easy as building up the resources, you can clean up and remove everything
again. Run `tofu destroy`, which will behave similar to the `apply` command.
After showing you a plan of the removal, it asks for your confirmation and then
cleans up everything. Run `kubectl get all,ing` to check what is left in your
namespace.
