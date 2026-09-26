module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source     = "./modules/network"
  vnet_name  = var.vnet_name
  subnet_name = var.subnet_name
  rg_name    = module.resource_group.name
  location   = var.location
}

module "hostpool" {
  source   = "./modules/hostpool"
  name     = var.hostpool_name
  rg_name  = module.resource_group.name
  location = var.location
}

module "workspace" {
  source   = "./modules/workspace"
  name     = var.workspace_name
  rg_name  = module.resource_group.name
  location = var.location
}

module "application_group" {
  source         = "./modules/application_group"
  name           = var.application_group_name
  rg_name        = module.resource_group.name
  location       = var.location
  hostpool_id    = module.hostpool.id
  workspace_id   = module.workspace.id
}

# Default VM (Pipeline 1)
module "vm" {
  source    = "./modules/vm"
  rg_name   = module.resource_group.name
  location  = var.location
  subnet_id = module.network.subnet_id
  size      = var.vm_size
  vm_names  = var.vm_names
}
