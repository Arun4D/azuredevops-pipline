#!/bin/sh

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <organization name> <project name> <repo name> <pipeline name>"
  exit 1
fi


# Variables
organization=$1
project=$2
repo=$3
pipeline_name=$4

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

pipelines=$(az pipelines list --name "$repo" --org "$organization" --project "$project" --query [].name  --output tsv)
if [ -z "$pipelines" ]; then
  echo "Pipeline $pipeline_name does not exist. Creating..."
  az pipelines create --name "$pipeline_name" --org "$organization"  --project "$project" --repository "$repo" --repository-type tfsgit --branch main --yaml-path /azure-pipelines.yml  --skip-first-run true
  echo "Pipeline $pipeline_name created successfully."
  
else
  echo "Pipeline $pipeline_name already exists."
fi

