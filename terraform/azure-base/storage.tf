///////////////////////////////////////////////
//////// Set Azure Variables //////////////////
///////////////////////////////////////////////

resource "random_id" "randomId" {
    byte_length = 10
}

resource "azurerm_storage_account" "bosh" {
  name                = "${random_id.randomId.hex}"
  resource_group_name = "${azurerm_resource_group.cf_resource_group.name}"

  location                 = "${var.region}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "bosh" {
  name                  = "bosh"
  resource_group_name   = "${azurerm_resource_group.cf_resource_group.name}"
  storage_account_name  = "${azurerm_storage_account.bosh.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "stemcell" {
  name                  = "stemcell"
  resource_group_name   = "${azurerm_resource_group.cf_resource_group.name}"
  storage_account_name  = "${azurerm_storage_account.bosh.name}"
  container_access_type = "blob"
}