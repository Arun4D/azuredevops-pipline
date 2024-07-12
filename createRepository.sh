#!/bin/sh

#GET https://dev.azure.com/{organization}/{project}/_apis/git/repositories?api-version=7.1-preview.1

#echo -n 'Arun Duraisamy:<<PAT>>' | base64
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <organization name> <project name> <repo name> "
  exit 1
fi

# Variables
organization=$1
project=$2
repository_name=$3

echo "Input Values"
echo "organization: $organization"
echo "project: $project"
echo "repository_name: $repository_name"
echo ""
 # Configure Azure DevOps CLI with PAT
echo $AZURE_DEVOPS_EXT_PAT | az devops login --organization $organization


# Azure DevOps login (you may need to authenticate if not already authenticated)
az devops configure --defaults organization=$organization project=$project

# Create the repository
az repos create --name $repository_name

# Output the created repository details
az repos show --repository $repository_name