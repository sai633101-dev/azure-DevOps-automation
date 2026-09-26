# ------------------------------------------------------------
# Create Log Analytics Workspace - Free Tier Friendly
# ------------------------------------------------------------
resource "azurerm_log_analytics_workspace" "law" {
  # Workspace name (unique per deployment)
  name                = "${var.resource_group_name}-law"

  # Location where workspace will be deployed
  location            = var.location

  # Resource Group in which workspace will be created
  resource_group_name = var.rg_name

  # SKU: PerGB2018 (cheapest option, free-tier friendly)
  sku                 = "PerGB2018"

  # Retention in days (keep minimal to save cost)
  retention_in_days   = 7

  tags = {
    environment = "avd"
    monitoring  = "loganalytics"
  }
}

# ------------------------------------------------------------
# Output: Log Analytics Workspace ID & Name
# ------------------------------------------------------------
output "id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "name" {
  value = azurerm_log_analytics_workspace.law.name
}
