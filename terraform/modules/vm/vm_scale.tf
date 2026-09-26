# ------------------------------------------------------------
# Scale-out Azure Virtual Desktop Session Host VMs - Free Tier Friendly
# ------------------------------------------------------------
resource "azurerm_windows_virtual_machine" "vm_scale" {
  # Loop through new VM names provided in var.vm_names
  for_each = toset(var.vm_names)

  # VM name
  name                = each.value

  # Location where VM will be deployed
  location            = var.location

  # Resource Group in which VM will be created
  resource_group_name = var.rg_name

  # VM size (small, free-tier friendly)
  size                = var.size   # e.g., Standard_B1s or Standard_B2s

  # Admin credentials (inject via Key Vault or DevOps variable group)
  admin_username      = "avdadmin"
  admin_password      = "ChangeMe123!"   # Replace with secure reference

  # Network interface (private only, no public IP)
  network_interface_ids = [
    azurerm_network_interface.vm_nic_scale[each.key].id
  ]

  # OS image (Windows 11 multi-session, latest build)
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-25h2-avd"
    version   = "latest"
  }

  # Storage settings (Standard HDD to stay free-tier friendly)
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_HDD"
  }

  # Boot diagnostics disabled (to save cost)
  boot_diagnostics {
    storage_account_uri = null
  }

  tags = {
    environment = "avd"
    vm_scale    = each.value
  }
}

# ------------------------------------------------------------
# Create NICs for scale-out VMs (private only)
# ------------------------------------------------------------
resource "azurerm_network_interface" "vm_nic_scale" {
  for_each = toset(var.vm_names)

  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    # No public_ip_address_id → ensures VM has only private IP
  }

  tags = {
    environment = "avd"
    vm_nic      = each.value
  }
}

# ------------------------------------------------------------
# Output: Scale-out VM IDs
# ------------------------------------------------------------
output "ids" {
  value = [for vm in azurerm_windows_virtual_machine.vm_scale : vm.id]
}
