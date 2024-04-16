resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address
  location            = var.vnet_loc
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "internal" {
  name                 = var.internal_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.internal_subnet_cidr
}

