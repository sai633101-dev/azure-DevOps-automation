# ------------------------------------------------------------
# Create Azure Key Vault - Free Tier Friendly
# ------------------------------------------------------------
resource "azurerm_key_vault" "kv" {
  # Key Vault name (must be globally unique)
  name                = "${var.resource_group_name}-kv"

  # Location where Key Vault will be deployed
  location            = var.location

  # Resource Group in which Key Vault will be created
  resource_group_name = var.rg_name

  # SKU: Standard (cheapest option, free-tier friendly)
  sku_name            = "standard"

  # Tenant ID (required for Key Vault)
  tenant_id           = data.azurerm_client_config.current.tenant_id

  # Access policies will be defined separately
  soft_delete_enabled = true
  purge_protection_enabled = false   # keep off to avoid extra cost

  tags = {
    environment = "avd"
    keyvault    = "secrets"
  }
}

# ------------------------------------------------------------
# Allow current user/service principal to access Key Vault
# ------------------------------------------------------------
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  # Permissions: secrets only (no keys/certs to save cost)
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}

# ------------------------------------------------------------
# Example Secret: Admin Password for AVD VMs
# ------------------------------------------------------------
resource "azurerm_key_vault_secret" "avd_admin_password" {
  name         = "avd-admin-password"
  value        = "ChangeMe123!"   # Replace with secure DevOps variable
  key_vault_id = azurerm_key_vault.kv.id
}

# ------------------------------------------------------------
# Output: Key Vault URI
# ------------------------------------------------------------
output "vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
