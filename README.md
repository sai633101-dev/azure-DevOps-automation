# azure-DevOps-automation
# Azure Virtual Desktop Automation (Terraform + Azure DevOps)

## 📌 Overview
This repo provides end-to-end automation for deploying **Azure Virtual Desktop (AVD)** using **Terraform** and **Azure DevOps pipelines**.  
It is designed to be **free-tier friendly** — minimal VM sizes, no public IPs, standard HDD storage, and lightweight monitoring.

---

## 🚀 Features
- Modular Terraform structure (RG, Network, Hostpool, Workspace, AppGroup, VMs, Storage, Key Vault, Log Analytics).
- Two pipelines:
  - **Pipeline 1** → Full infra + 1 default VM.
  - **Pipeline 2** → Scale-out VMs only.
- Secure secrets management via **Key Vault**.
- Lightweight monitoring via **Log Analytics**.
- Terraform state stored in **Storage Account**.

---

## 📂 Repo Structure
├── modules/
│   ├── resource_group/
│   ├── network/
│   ├── hostpool/
│   ├── workspace/
│   ├── application_group/
│   ├── vm/
│   ├── storage/
│   ├── keyvault/
│   └── loganalytics/
├── pipelines/
│   ├── infra-pipeline.yml
│   ├── vm-scale-pipeline.yml
│   └── templates/
│       ├── build.yml
│       ├── plan.yml
│       ├── apply.yml
│       └── sonar.yml
└── README.md


---

## 🛠️ Prerequisites
- Azure free-tier account
- Azure DevOps project
- Service connection to Azure
- Terraform v1.5+
- Variable group in DevOps (`avd-hostpool1-vars`) with:
  - `rg_name`
  - `location`
  - `vm_names`
  - `size` (Standard_B1s or B2s)
  - `admin_username`
  - `admin_password` (stored in Key Vault)

---

## 🚦 Pipelines
- **Pipeline 1** → Deploys infra + 1 VM.
- **Pipeline 2** → Adds more VMs (scale-out).

---

## 📌 Notes
- All infra is **free-tier friendly**.
- No public IPs are created.
- Storage uses **Standard_LRS**.
- Log Analytics retention = 7 days.

