# azuredevops-pipline

Azure DevOps master pipeline create new pipeline based on the services

## Build

[Master build pipleline](./build.yml) has three step

1. Create Repository based on service name
2. Clone newly created repository and create release pipeline azure-pipelines.yml file based on templates in src directory
3. Create Release pipeline and skip first build

## Templates
Creates templates in src directory and map it accordingly in [cloneRepository.sh](./cloneRepository.sh) 

## Deprecated
Instead of [createRepo.sh](./createRepo.sh) use [createRepository.sh](./createRepository.sh).  [createRepo.sh](./createRepo.sh) is deprecated 