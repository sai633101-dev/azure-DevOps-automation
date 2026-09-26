# ------------------------------------------------------------
# Create Azure Virtual Desktop Workspace
# ------------------------------------------------------------
resource "azurerm_virtual_desktop_workspace" "workspace" {
  # Workspace name (unique per deployment)
  name                = var.name

  # Location where workspace will be deployed
  location            = var.location

  # Resource Group in which workspace will be created
  resource_group_name = var.rg_name

  # Friendly name for easier identification in portal
  friendly_name       = "${var.name}-friendly"

  # Tags for governance and tracking
  tags = {
    environment = "avd"
    workspace   = var.name
  }
}

# ------------------------------------------------------------
# Output: Workspace ID
# ------------------------------------------------------------
output "id" {
  value = azurerm_virtual_desktop_workspace.workspace.id
}
