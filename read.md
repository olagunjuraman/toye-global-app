## Simple Node App Deployment Guide

This guide provides instructions on how to deploy the Simple Node App to a Kubernetes cluster using Helm.

### Prerequisites
- Access to an EKS Kubernetes cluster
- Helm 3 installed on your local machine
- `kubectl` configured to connect to your Kubernetes cluster

### Step 1: Cloning the Repository
Clone the repository to get the required deployment files and Helm chart:
git clone https://github.com/yourusername/simple-node-app.git
cd simple-node-app

### Step 2: Setting Up Helm
Helm 3 does not require Tiller. Ensure Helm is installed and ready:
helm version
This command should return the version of Helm installed on your machine.

### Step 3: Installing the Application Using Helm
Navigate to the Helm chart directory and deploy the application using Helm:
cd chart
helm install simple-node-app .
Adjust the `values.yaml` file if necessary to match your deployment preferences or environment requirements.

### Step 4: Accessing the Application
To access the application, locate the external IP address of the LoadBalancer:
kubectl get svc --namespace default -w | grep LoadBalancer
This command watches for the LoadBalancer service to be available and displays its external IP address. Use this IP address to access the deployed Node.js application through the web browser or API client.

### Step 5: Verifying the Deployment
Check the status of the deployed pods to ensure they are running correctly:
kubectl get pods
This command lists all pods and shows their status, helping you verify if the deployment was successful.
