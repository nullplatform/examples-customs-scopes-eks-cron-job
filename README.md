# EKS CronJob custom scopes
This is an example of how an EKS CronJob can be implemented in nullplatform using the custom scopes technology.

## Components
This repo includes 2 main components:

1. A GitHub Actions workflow that processes the actions triggers, locates the correct script, and executes it.
2. A set of scripts that implements the lifecycle of a CronJob in EKS.

### GitHub workflow
This process has 3 main responsibilities:

1. Install all necessary dependencies (e.g., nullplatform CLI, AWS CLI, kubectl).
2. Process the payload to locate the script to execute and export all needed environment variables. See [prepare-script.js](/.github/workflows/scripts/prepare-script.js) for more details on how this works.
3. Use the nullplatform CLI to report the result of the script execution.

You can find the workflow at [.github/workflows/scripting.yml](/.github/workflows/scripting.yml).

### Deploying to Kubernetes
The deployment lifecycle of CronJobs to a Kubernetes cluster is implemented in 3 steps. Each lifecycle action just needs to mix and match these steps in different ways to do its work.

These steps are:

1. **Build the deployment context:** This step uses the nullplatform CLI to fetch all the context information needed to properly configure and tag the CronJob.
2. **Connect to the Kubernetes cluster:** This step first uses the AWS CLI to get credentials and then uses the kubectl utility to connect to the cluster.
3. **Build the CronJob manifest and apply it to the cluster:** It uses the gomplate utility to fill the manifest template and then apply it through kubectl.

You can find the scripts at [eks-cron-job](eks-cron-job).
