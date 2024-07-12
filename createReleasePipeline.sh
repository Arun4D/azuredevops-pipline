#!/bin/sh

#GET https://dev.azure.com/{organization}/{project}/_apis/git/repositories?api-version=7.1-preview.1

#echo -n 'Arun Duraisamy:<<PAT>>' | base64
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <organization name> <project name> <repo name> <pipeline name>"
  exit 1
fi


# Variables
organization=$1
project=$2
repo=$3
pipeline_name=$4

#organization="https://dev.azure.com/YOUR_ORG_NAME"
#project="YOUR_PROJECT_NAME"
#repo="YOUR_REPO_NAME"
#pipeline_name="Sample Pipeline"

echo "Input Values"
echo "organization: $organization"
echo "project: $project"
echo "repo: $repo"
echo "pipeline_name: $pipeline_name"
echo ""

 # Configure Azure DevOps CLI with PAT
echo $AZURE_DEVOPS_EXT_PAT | az devops login --organization $organization

# Azure DevOps login (you may need to authenticate if not already authenticated)
az devops configure --defaults organization=$organization project=$project

az pipelines show --name "$repo" --org "$organization" --repository "$repo" &> /dev/null
if [ $? -eq 0 ]; then
  echo "Pipeline $pipeline_name already exists."
else
  echo "Pipeline $pipeline_name does not exist. Creating..."
  # Create the pipeline using az pipelines create command
  az pipelines create --name "$pipeline_name" --org "$organization" --repository "$repo" --repository-type tfsgit --branch main --yaml-path /azure-pipelines.yml  --skip-first-run true
  echo "Pipeline $pipeline_name created successfully."
fi

