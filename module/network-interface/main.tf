resource "azurerm_network_interface" "vm_nic1" {
  name                = var.vm_nic_name
  location            = var.rg_loc
  resource_group_name = var.rgname

  ip_configuration {
    name                          = var.publicip_name
    subnet_id                     = var.internal_subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_publicip.id
  }
}
resource "azurerm_public_ip" "vm_publicip" {
  name                = var.publicip_name
  location            = var.rg_loc
  resource_group_name = var.rgname
  allocation_method   = "Dynamic"
}