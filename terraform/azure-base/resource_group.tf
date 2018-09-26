///////////////////////////////////////////////
//////// Set Azure Resource Group /////////////
///////////////////////////////////////////////

resource "azurerm_resource_group" "cf_resource_group" {
  name     = "${var.resource_group}"
  location = "${var.region}"

  tags {
    autostop = "no"
  }
}