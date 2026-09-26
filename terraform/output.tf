output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "hostpool_id" {
  value = module.hostpool.id
}

output "workspace_id" {
  value = module.workspace.id
}

output "application_group_id" {
  value = module.application_group.id
}

output "vm_ids" {
  value = module.vm.ids
}
