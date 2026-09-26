# ------------------------------------------------------------
# Create Azure Virtual Desktop Application Group
# ------------------------------------------------------------
resource "azurerm_virtual_desktop_application_group" "appgroup" {
  # Application Group name (unique per deployment)
  name                = var.name

  # Location where app group will be deployed
  location            = var.location

  # Resource Group in which app group will be created
  resource_group_name = var.rg_name

  # Type of app group:
  # "Desktop" → full desktop experience
  # "RemoteApp" → published applications only
  type                = "Desktop"

  # Link to the Hostpool created earlier
  host_pool_id        = var.hostpool_id

  # Friendly name for easier identification in portal
  friendly_name       = "${var.name}-friendly"

  # Tags for governance and tracking
  tags = {
    environment = "avd"
    appgroup    = var.name
  }
}

# ------------------------------------------------------------
# Associate Application Group with Workspace
# ------------------------------------------------------------
resource "azurerm_virtual_desktop_workspace_application_group_association" "workspace_link" {
  # Workspace ID from workspace module
  workspace_id        = var.workspace_id

  # Application Group ID created above
  application_group_id = azurerm_virtual_desktop_application_group.appgroup.id
}

# ------------------------------------------------------------
# Output: Application Group ID
# ------------------------------------------------------------
output "id" {
  value = azurerm_virtual_desktop_application_group.appgroup.id
}
