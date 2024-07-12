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

git clone https://$AZURE_DEVOPS_EXT_PAT@dev.azure.com/$targetRepo target-repo
cd target-repo
git config --global init.defaultBranch main
git config --global user.email "$git_user_email"
git config --global user.name "$git_user_name"
git branch -m main
if [ -e azure-pipelines.yml ]
then
    echo "File azure-pipelines.yml already exists"
else
    echo "File azure-pipelines.yml does not exist. Creating..."
    cp ../src/bicep/azure-pipelines.yml azure-pipelines.yml 
    git add azure-pipelines.yml 
    git commit -m "Add azure-pipelines.yml file via Azure Pipeline"
fi

git push -u origin --all