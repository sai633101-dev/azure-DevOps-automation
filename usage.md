# Usage Guide

## 🚀 Running Pipeline 1 (Infra)
1. Commit Terraform code to `main`.
2. Pipeline triggers automatically.
3. Pipeline stages:
   - Build → Init + Validate
   - Plan → Generate plan file
   - Apply → Deploy infra

Result: RG, VNet, Hostpool, Workspace, AppGroup, Storage, Key Vault, Log Analytics, and 1 default VM.

---

## 🚀 Running Pipeline 2 (VM Scale-Out)
1. Update `vm_names` in variable group.
2. Commit changes to `main`.
3. Pipeline triggers automatically.
4. Pipeline stages:
   - Build → Init + Validate
   - Plan → Target `module.vm_scale`
   - Apply → Deploy new VMs

Result: Extra VMs added to hostpool, infra unchanged.

---

## 🔑 Secrets Management
- Admin password stored in **Key Vault** (`avd-admin-password`).
- Pipelines fetch secrets securely.

---

## 📊 Monitoring
- Log Analytics workspace created with 7-day retention.
- Can be linked to Azure Monitor for dashboards.

---

## 🛠️ Free Tier Tips
- Use small VM sizes (`Standard_B1s`, `Standard_B2s`).
- Avoid premium storage.
- Keep retention low.
- No public IPs.
