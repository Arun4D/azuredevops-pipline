#!/bin/sh

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <targetRepo> <git_user_email> <git_user_name> "
  exit 1
fi

# Variables
targetRepo=$1
git_user_email=$2
git_user_name=$3

echo "Input Values"
echo "targetRepo: $targetRepo"
echo "git_user_email: $git_user_email"
echo "git_user_name: $git_user_name"
echo ""
 # Configure Azure DevOps CLI with PAT
echo $AZURE_DEVOPS_EXT_PAT | az devops login --organization $organization


git clone https://$AZURE_DEVOPS_EXT_PAT@dev.azure.com/$targetRepo target-repo
cd target-repo
cp ../src/bicep/azure-pipeline.yml azure-pipeline.yml 
git config --global user.email "$git_user_email"
git config --global user.name "$git_user_name"
git add azure-pipeline.yml 
git commit -m "Add azure-pipeline.yml file via Azure Pipeline"
git push https://$AZURE_DEVOPS_EXT_PAT@dev.azure.com/$targetRepo