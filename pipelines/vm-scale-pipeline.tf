# ------------------------------------------------------------
# Azure DevOps Pipeline 2 - VM Scale-Out
# Adds new session host VMs into existing AVD hostpool
# ------------------------------------------------------------
trigger:
  branches:
    include:
      - main

pool:
  vmImage: 'ubuntu-latest'

variables:
  - group: avd-vm-scale-vars   # Variable group with RG, subnet, VM size, creds

stages:
  - stage: Build
    jobs:
      - job: TerraformBuild
        steps:
          - task: TerraformInstaller@0
            inputs:
              terraformVersion: '1.5.0'

          - script: |
              terraform init -backend-config="resource_group_name=rg-tfstate-avd" \
                             -backend-config="storage_account_name=sttfstateavd" \
                             -backend-config="container_name=tfstate" \
                             -backend-config="key=$(hostpool_name).tfstate"
            displayName: 'Terraform Init'

          - script: terraform validate
            displayName: 'Terraform Validate'

  - stage: Plan
    jobs:
      - job: TerraformPlan
        steps:
          - script: terraform plan -target=module.vm_scale -out=tfplan
            displayName: 'Terraform Plan (VM Scale-Out Only)'

          - task: PublishBuildArtifacts@1
            inputs:
              PathtoPublish: 'tfplan'
              ArtifactName: 'tfplan'
              publishLocation: 'Container'

  - stage: Apply
    jobs:
      - job: TerraformApply
        steps:
          - download: current
            artifact: tfplan

          - script: terraform apply tfplan
            displayName: 'Terraform Apply (VM Scale-Out)'
