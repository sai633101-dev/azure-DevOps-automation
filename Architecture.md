# Azure Virtual Desktop Automation Architecture

## 📌 High-Level Flow
1. **Resource Group (RG)** → Base container for all resources.
2. **Network (VNet + Subnet + NSG)** → Provides secure private connectivity.
3. **Hostpool** → Core AVD infra, manages session hosts.
4. **Workspace** → User-facing entry point in AVD client.
5. **Application Group (AppGroup)** → Links hostpool to workspace, defines Desktop/RemoteApp.
6. **VMs** → Session hosts (Pipeline 1 deploys 1 default VM, Pipeline 2 adds more).
7. **Storage Account** → Holds Terraform state + optional diagnostics.
8. **Key Vault** → Stores secrets (admin password).
9. **Log Analytics** → Captures monitoring data (lightweight, free-tier friendly).

---

## 📊 Diagram (Textual Representation)

+-------------------+
|   Resource Group  |
+-------------------+
|
v
+-------------------+
|   Virtual Network |
|  + Subnet + NSG   |
+-------------------+
|
v
+-------------------+        +-------------------+
|     Hostpool      |<------>|   Application     |
|                   |        |      Group        |
+-------------------+        +-------------------+
|                           |
v                           v
+-------------------+        +-------------------+
|    Workspace      |        |   Session Hosts   |
| (User entry point)|        |   (VMs, scale)    |
+-------------------+        +-------------------+
|
v
+-------------------+
|   AVD Client      |
| (Users connect)   |
+-------------------+

Supporting Services:

Storage Account → Terraform state

Key Vault → Secrets

Log Analytics → Monitoring

Code

---

## 🎯 Notes
- **Free-tier friendly**: small VM sizes, HDD storage, no public IPs, minimal retention.  
- **Pipelines**:  
  - Pipeline 1 → Deploys everything + 1 VM.  
  - Pipeline 2 → Adds extra VMs only.  

---

✅ With this, your repo now has **code + pipelines + docs + architecture diagram**.  


