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
