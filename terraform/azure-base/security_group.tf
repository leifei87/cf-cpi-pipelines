///////////////////////////////////////////////
//////// Set Azure security group /////////////
///////////////////////////////////////////////

resource "azurerm_network_security_group" "bosh" {
  name                = "${var.bosh_security_group}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.cf_resource_group.name}"
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.bosh.name}"
}

resource "azurerm_network_security_rule" "bosh-agent" {
  name                        = "bosh-agent"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6868"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.bosh.name}"
}

resource "azurerm_network_security_rule" "bosh-director" {
  name                        = "bosh-director"
  priority                    = 202
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "25555"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.bosh.name}"
}

resource "azurerm_network_security_rule" "dns" {
  name                        = "dns"
  priority                    = 203
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.bosh.name}"
}

resource "azurerm_network_security_rule" "credhub" {
  name                        = "credhub"
  priority                    = 204
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8844"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.bosh.name}"
}



resource "azurerm_network_security_group" "cf" {
  name                = "${var.cf_security_group}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.cf_resource_group.name}"
}

resource "azurerm_network_security_rule" "cf-https" {
  name                        = "cf-https"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.cf.name}"
}

resource "azurerm_network_security_rule" "cf-log" {
  name                        = "cf-log"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "4443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.cf.name}"
}

resource "azurerm_network_security_rule" "cf-http" {
  name                        = "cf-http"
  priority                    = 202
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.cf.name}"
}

resource "azurerm_network_security_rule" "cf-ssh" {
  name                        = "cf-ssh"
  priority                    = 203
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2222"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.cf_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.cf.name}"
}