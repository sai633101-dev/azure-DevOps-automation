terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name   = "rg-tfstate-avd"       # RG for state storage
    storage_account_name  = "sttfstateavd"         # Storage account for state
    container_name        = "tfstate"              # Blob container
    key                   = "${var.hostpool_name}.tfstate" # Unique per hostpool
  }
}

provider "azurerm" {
  features {}
}
