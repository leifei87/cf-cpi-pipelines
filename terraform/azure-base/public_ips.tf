///////////////////////////////////////////////
//////// Set Azure Public IP //////////////////
///////////////////////////////////////////////

resource "azurerm_public_ip" "bosh" {
  name                         = "publicip-bosh"
  location                     = "${var.region}"
  resource_group_name          = "${azurerm_resource_group.cf_resource_group.name}"
  public_ip_address_allocation = "static"

}

resource "azurerm_public_ip" "cf" {
  name                         = "publicip-cf"
  location                     = "${var.region}"
  resource_group_name          = "${azurerm_resource_group.cf_resource_group.name}"
  public_ip_address_allocation = "static"

}