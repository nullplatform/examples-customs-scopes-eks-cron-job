# EKS Cron Job Custom Scopes
This is an example of how an EKS Cron Job can be implemented in nullplatform using the custom scopes technology

## Components
This repo includes 2 main components:

1. A GitHub Actions Workflow that processes the actions triggers, locates the correct script and executes.
2. A set of scripts that implement the lifecycle of a cron job in EKS.

### GitHub Workflow
This process has 3 main responsibilities:

1. Install all needed dependencies (e.g: nullplatform cli, aws cli, kubectl).
2. Process the payload to locate the script to execute and export all needed environment variables. See [prepare-script.js](/.github/workflows/scripts/prepare-script.js) for more details on how this works.
3. Use the nullplatform cli to report the result of the script.

You can find the workflow at [.github/workflows/scripting.yml](/.github/workflows/scripting.yml).

### Deploying to Kubernetes
The deployment lifecycle of cron jobs to a Kubernetes cluster is implemented with 3 steps. Each lifecycle action just needs to mix and match these steps in different ways to do its work.

These steps are:

1. Build the deployment context. This step uses the nullplatform cli to fetch all the context information needed to properly configure and tag the cron job.
2. Connect to the Kubernetes cluster. This step first uses the aws cli to get credentials and then uses the kubectl utility to connect to the cluster.
3. Build the cron job manifest and apply to the cluster. It uses the gomplate utility to fill the manifest template and then apply it through kubectl.

You can find the scripts at [eks-cron-job](eks-cron-job).
