///////////////////////////////////////////////
//////// Set VNET and Subnets /////////////////
///////////////////////////////////////////////

resource "azurerm_virtual_network" "cf_virtual_network" {
  name                = "${var.vnet_name}"
  address_space       = ["${var.network_cidr}"]
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.cf_resource_group.name}"
}

resource "azurerm_subnet" "bosh" {
  name                 = "${var.bosh_subnet_name}"
  address_prefix       = "${var.bosh_subnet_cidr}"
  resource_group_name  = "${azurerm_resource_group.cf_resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.cf_virtual_network.name}"
}

resource "azurerm_subnet" "cf" {
  name                 = "${var.cf_subnet_name}"
  address_prefix       = "${var.cf_subnet_cidr}"
  resource_group_name  = "${azurerm_resource_group.cf_resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.cf_virtual_network.name}"
}
