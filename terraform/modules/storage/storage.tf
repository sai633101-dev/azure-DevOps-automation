# ------------------------------------------------------------
# Create Azure Storage Account for AVD (Diagnostics/Logs)
# Free-tier friendly: Standard_LRS, no premium features
# ------------------------------------------------------------
resource "azurerm_storage_account" "storage" {
  # Storage account name must be globally unique, lowercase, no special chars
  name                     = "${var.resource_group_name}stdiag"

  # Location where storage account will be deployed
  location                 = var.location

  # Resource Group in which storage account will be created
  resource_group_name      = var.rg_name

  # SKU: Standard_LRS (cheapest option, free-tier friendly)
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Disable advanced features to save cost
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  tags = {
    environment = "avd"
    storage     = "diagnostics"
  }
}

# ------------------------------------------------------------
# Create Blob Container for logs/state
# ------------------------------------------------------------
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# ------------------------------------------------------------
# Output: Storage Account & Container
# ------------------------------------------------------------
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}
