# ------------------------------------------------------------
# Create Azure Virtual Desktop Host Pool
# ------------------------------------------------------------
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  # Hostpool name (unique per deployment)
  name                = var.name

  # Location where hostpool will be deployed
  location            = var.location

  # Resource Group in which hostpool will be created
  resource_group_name = var.rg_name

  # Hostpool type: "Pooled" (shared session hosts) or "Personal" (dedicated VMs per user)
  type                = "Pooled"

  # Load balancing algorithm:
  # "BreadthFirst" → spread sessions evenly across VMs
  # "DepthFirst"   → fill one VM before moving to the next
  load_balancer_type  = "BreadthFirst"

  # Friendly name for easier identification in portal
  friendly_name       = "${var.name}-friendly"

  # Maximum concurrent sessions allowed per VM
  maximum_sessions_allowed = 10

  # Preferred app group type: "Desktop" for full desktop, "RemoteApp" for published apps
  preferred_app_group_type = "Desktop"

  # Tags for governance and tracking
  tags = {
    environment = "avd"
    hostpool    = var.name
  }
}

# ------------------------------------------------------------
# Output: Hostpool ID
# ------------------------------------------------------------
output "id" {
  value = azurerm_virtual_desktop_host_pool.hostpool.id
}
