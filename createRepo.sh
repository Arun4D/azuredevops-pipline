#!/bin/sh

#GET https://dev.azure.com/{organization}/{project}/_apis/git/repositories?api-version=7.1-preview.1

#echo -n 'Arun Duraisamy:<<PAT>>' | base64
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <microservice name> <authization header text>"
  exit 1
fi

checkName=$1
PAT=$2
#checkName='microservice-repo1'

organization='arun4duraisamy0719'
projectName='Bicep-demo'
projectId='ebf97fe7-b4eb-4ad2-8d6c-2103d3c9f521'
isNameExists=0

echo "=============scrit start ========================="

GetRepoResponse=$(curl --location --request GET "https://dev.azure.com/$organization/$projectName/_apis/git/repositories?api-version=7.1-preview.1" -H "$PAT" -H 'Cache-Control: no-cache')

echo $GetRepoResponse
echo ""

for row in $(echo "$GetRepoResponse" | jq -c '.value[]'); do
  name=$(echo "$row" | jq -r '.name')
  if [ "$name" = "$checkName" ]; then
    echo "Repo Name $name found, exiting loop."
    echo ""
    isNameExists=1
    break
  fi
done

if [ "$isNameExists" -eq 0 ]; then
    echo "Repo Name $name not found"
    echo ""
    echo "Creating repo $name "
    echo ""
    CreateRepoResponse=$(curl --location --request POST "https://dev.azure.com/$organization/$project/_apis/git/repositories?api-version=7.1-preview.1" -H "$PAT" -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' --data '{"name":"'${checkName}'","project": {  "id": "'${projectId}'" } }')
    echo $CreateRepoResponse
    echo ""
    repoUrl=$(echo "$CreateRepoResponse" | jq -r '.url') 
    echo "Repo url: $repoUrl"
    echo ""
fi


echo "=============scrit end  ============================"
