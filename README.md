# Deploy Ruby on rails on AKS using Azure DevOps & Terraform

**Prerequisites:**

- Azure account with subscription

- Azure DevOps

**Tools Used:**

- Terraform

- Azure Cloud

- Azure DevOps

**IaaC:**

Azure DevOps pipeline with Terraform is used for infrastructure provisioning. With this pipeline Resource group, storage account with container, ACR and AKS cluster attached to the ACR will be created.

## Architecture

!["Infrastructure"](assets/azure-terrafrom.jpg?raw=true)

!["Deployment Architecture"](assets/deployment-archi.jpg?raw=true)

## Azure DevOps

Use this URL [https://dev.azure.com](https://dev.azure.com) for Azure DevOps platform
- Go to Azure DevOps and create an organization and a project in the organization
- Terraform extension needs to be installed from the Azure DevOps market place.

#### Service Principal (manual)

[Service principal](https://learn.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) is required to connect from Azure to Azure DevOps, follow the steps below.

<u>For azure CLI login</u>:

```
az login
```

<u> Create a resource group for the service principal</u>:

```
az group create --name <resource-group> -l <location>
```
<u> Create Azure service principal for Azure DevOps</u>:
```
az ad sp create-for-rbac --name aks-sp \
	--role contributor \
	--scopes /subscriptions/<subscription-id>/resourceGroups/<resource-group>
```
Make sure to copy the results safely to somewhere. It is required in further steps.

Below permissions are required for service principal:

    AAD permission => Application administrator
    Subscriptions => Owner

 
> Note: For attaching ACR to AKS, owner permission is required

## Steps to run pipeline

 1. From project settings, create [service connection](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml).
 2. Navigate to your project and create a new pipeline. Connect your GitHub repo where this code is pushed. Grant permission to the github repo, it will create an automatic service connection.
 3. Select 'Existing Azure Pipelines YAML file', choose branch and path '/azure-pipelines.yml'
 4. Ensure to change your service connections in the pipeline
 5. Click run. Select the parameter 'apply', then run
 6. After the job is completed, verify the resources are created in Azure.

## Steps to deploy application on AKS

1. Create another pipeline in Azure DevOps with connecting the same GitHub repo.

2. Select 'Existing Azure Pipelines YAML file', choose branch and path '/azure-pipelines-deploy.yml'

3. Modify image repository path in deployment.yaml

> Note: Before running the pipeline, need to modify the image repository
> path like this

    <containerregistry>.azurecr.io/<gitusername><gitreponame>_practicum.rails.api:latest

4. Run pipeline

5. Go to the AKS cluster in Azure, check workloads and verify the pods are running. Then go to 'services and ingresses', check services you will see an external ip in the service.

6. Check in browser `http://<external-ip>:3000`

### Improvements:
Needs some optimization in the 3rd step of deploy application on AKS. Using bash script/powershell can do string manipulations on deployment.yaml for changing the image repo path.