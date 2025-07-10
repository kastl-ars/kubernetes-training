# Linting and testing a helm chart

## Basics

You can easily check, if your chart can be rendered, given the values you
supply.

```
helm chart create my-chart
cd my-chart
# missing values or wrong syntax will show up in the next command
helm template . | tee output.yml
# check output.yml for errors
```

But what about more thorough checks and tests? This is where
[chart-testing](https://github.com/helm/chart-testing) comes in...

The chart-testing tool is using a remote repository to find out, which charts
where changed and thus need to be tested and linted. There is a example
repository that you can clone and start from.

```
git clone https://github.com/kastl-ars/chart-testing-example.git
cd chart-testing-example
git branch my-feature-branch
git switch my-feature-branch
# make changes to charts/my-second-chart/Chart.yaml
sed -i 's/version: 0\..\.0/version: 0.3.0/g' charts/my-second-chart/Chart.yaml
git diff charts/my-second-chart/Chart.yaml
```

Now we can start using the chart-testing tool. First, in a pipeline you can find
out which of the charts was changed (and thus needs to be tested).

```
$ ct list-changed
charts/my-second-chart
$
```

Not really spectacular, but comes in handy.

Next, let's lint our chart:

```
$ ct lint
Linting charts...
Error: failed loading configuration: 'chart_schema.yaml' neither specified nor found in default locations
failed loading configuration: 'chart_schema.yaml' neither specified nor found in default locations
$
```

## Adding the chart-testing configuration files

* Copy `lintconf.yaml` to the `~/my_local_chart_directory` directory
* Copy `chart_schema.yaml` to the `~/my_local_chart_directory` directory
* Run `ct lint` again and you should get some output.

```
$ ct lint
Linting charts...

------------------------------------------------------------------------------------------------------------------------
 Charts to be processed:
------------------------------------------------------------------------------------------------------------------------
 my-second-chart => (version: "0.2.0", path: "charts/my-second-chart")
------------------------------------------------------------------------------------------------------------------------

Linting chart "my-second-chart => (version: \"0.2.0\", path: \"charts/my-second-chart\")"
Checking chart "my-second-chart => (version: \"0.2.0\", path: \"charts/my-second-chart\")" for a version bump...
Old chart version: 0.1.0
New chart version: 0.2.0
Chart version ok.

------------------------------------------------------------------------------------------------------------------------
 ✖︎ my-second-chart => (version: "0.2.0", path: "charts/my-second-chart") > failed running process: exec: "yamale": executable file not found in $PATH
------------------------------------------------------------------------------------------------------------------------
Error: failed linting charts: failed processing charts
failed linting charts: failed processing charts
$
```

As we only made changes to our `my-second-chart` chart, only this one is being
linted.

As it was changed, it needs a version bump (which we made).

But the `yamale` executable was not found.

OK, Plan B, run `ct` from the official container.

```
$ docker run -it --rm --workdir=/data --volume $(pwd):/data quay.io/helmpack/chart-testing:latest ct lint
Linting charts...

------------------------------------------------------------------------------------------------------------------------
No chart changes detected.
------------------------------------------------------------------------------------------------------------------------
Error: failed linting charts: failed identifying charts to process: must be in a git repository
failed linting charts: failed identifying charts to process: must be in a git repository
$
```

The error is misleading. There is a git repository, but due to security
concerns, the git executable inside the container refuses to work with it.

Create a gitconfig file, mount it to `/root/.gitconfig/` inside the container
and try again:

```
$ cat <<EOF > gitconfig
> [safe]
> directory = /data
> EOF
$ docker run -it --rm --workdir=/data -v ./gitconfig:/root/.gitconfig -v $(pwd):/data quay.io/helmpack/chart-testing:latest ct lint
Linting charts...

------------------------------------------------------------------------------------------------------------------------
 Charts to be processed:
------------------------------------------------------------------------------------------------------------------------
 my-second-chart => (version: "0.3.0", path: "charts/my-second-chart")
------------------------------------------------------------------------------------------------------------------------

Linting chart "my-second-chart => (version: \"0.3.0\", path: \"charts/my-second-chart\")"
Checking chart "my-second-chart => (version: \"0.3.0\", path: \"charts/my-second-chart\")" for a version bump...
Old chart version: 0.1.0
New chart version: 0.3.0
Chart version ok.
Validating charts/my-second-chart/Chart.yaml...
Validation success! 👍
Validating maintainers...

------------------------------------------------------------------------------------------------------------------------
 ✖︎ my-second-chart => (version: "0.3.0", path: "charts/my-second-chart") > chart doesn't have maintainers
------------------------------------------------------------------------------------------------------------------------
Error: failed linting charts: failed processing charts
failed linting charts: failed processing charts

$
```

Hooray, we have linting results. We are missing a `maintainers` section, but the
chart is mostly fine.

Play around with the chart, remove fields from the `Chart.yaml`. Break the YAML
syntax in files. Run the command again and check, if your mistakes are being
found.
