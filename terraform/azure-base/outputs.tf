///////////////////////////////////////////////
//////// Output the variable //////////////////
///////////////////////////////////////////////

output "resource_group_name" {
  value = "${azurerm_resource_group.cf_resource_group.name}"
}

output "storage_account_name" {
  value = "${azurerm_storage_account.bosh.name}"
}

output "bosh_external_ip" {
  value = "${azurerm_public_ip.bosh.ip_address}"
}

output "cf_external_ip" {
  value = "${azurerm_public_ip.cf.ip_address}"
}