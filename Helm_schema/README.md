# Create a schema for your helm chart

When using a helm chart, you can use which ever values you want. Whether or not
they make sense (using an integer where the chart expects a string, using the
image name as the number of replicas,...) is not easy to find our as a user.

A helm schema can help, as the chart author(s) can define boundaries for you to
use the chart safely. A schema can make sure that the number of replicas is an
integer, not a string and not a list or array. It can make sure that the image
name is not empty.

# Creating a schema for your helm chart

Clone the [example chart
repository](https://github.com/kastl-ars/chart-testing-example.git).

Switch into the directory into the `my-second-chart`.

```
git clone https://github.com/kastl-ars/chart-testing-example.git
cd chart-testing-example
cd charts/my-second-chart/
```

Install the helm plugin `helm schema`:

```
helm plugin install https://github.com/dadav/helm-schema
```

Run the `helm schema` command to create a JSON file containing your chart.

Commit the `values.schema.json` file, then make a change to your `values.yaml`
file.

Add three lines before the comment above the `imagePullSecrets` setting:

```
# @schema
# required: false
# @schema
# This is for the secrets for pulling an image from a private repository more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
imagePullSecrets: []
```

Run `helm schema` again and check the differences in your `values.schema.json`.

```
$ git diff values.schema.json
diff --git a/charts/my-second-chart/values.schema.json b/charts/my-second-chart/values.schema.json
index e5ae69d..91eb7d5 100644
--- a/charts/my-second-chart/values.schema.json
+++ b/charts/my-second-chart/values.schema.json
@@ -97,8 +97,7 @@
         "required": []
       },
       "required": [],
-      "title": "imagePullSecrets",
-      "type": "array"
+      "title": "imagePullSecrets"
     },
     "ingress": {
       "additionalProperties": false,
@@ -417,7 +416,6 @@
   "required": [
     "replicaCount",
     "image",
-    "imagePullSecrets",
     "nameOverride",
     "fullnameOverride",
     "serviceAccount",

$
```

Without going into details, you can influence e.g. if parameters are required or
optional. Check the helm schema documentation for what you can do with helm
schema.
