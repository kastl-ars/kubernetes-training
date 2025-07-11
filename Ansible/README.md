# Ansible and k8s

You can use Ansible to deploy resources in Kubernetes. In constrast to
Terraform/OpenTofu it is not possible, to remove those resources automatically.

To work with this example Ansible code, you need Ansible installed on your
laptop. This machine, commonly called "Ansible control host", then reaches out
to other systems and "does things". This could be via SSH to a linux VM, where
it installs a database or a webserver.

But Ansible also allows talking to APIs to "do things". In our case, we will be
talking to the Kubernetes API. So, in addition to Ansible you also need the
Python `kubernetes` module on the Ansible control host as well as the
`kubernetes.core` collection.

On our Jumphost VM everything is installed already, so nothing to do.

From within this `Ansible` directory, issue the following command to do a
"dry-run":

```bash
ansible-playbook --check --diff playbook-nginx_and_pvcs.yml -e target_namespace=schulungXXwork
```

(As usual, make sure to adjust the namespace name)

The `--check` parameter makes this a "dry-run", which does not change anything,
but only shows what it **would** do. `--diff` shows what changes would be made,
this is helpful for e.g. configuration files.

As you will notice from the output, there is a file missing in this directory.
Once you have that, run the command again without `--check --diff` and you
should have a shiny nginx helm release in your namespace...
