resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = var.vmname
  resource_group_name             = var.rgname
  location                        = var.rg_loc
  size                            = var.size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids           = var.vm_nic_id

  os_disk {
    caching              = var.disk_cache
    storage_account_type = var.disk_storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }
}

resource "azurerm_network_security_group" "nsgname" {
name = var.nsgname
resource_group_name = var.rgname
location = var.rg_loc
dynamic "security_rule" {
  for_each = var.nsgrules
  content {
    name                      = security_rule.value["name"]
  direction                   = security_rule.value["direction"]
  access                      = security_rule.value["access"]
  priority                    = security_rule.value["priority"]
  protocol                    = security_rule.value["protocol"]
  source_port_range           = security_rule.value["source_port_range"]
  destination_port_range      = security_rule.value["destination_port_range"]
  source_address_prefix       = security_rule.value["source_address_prefix"]
  destination_address_prefix  = security_rule.value["destination_address_prefix"] 
    
  }  
}
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = var.vm_nic_id[0]
  # network_security_group_id = var.var_nsgid
  network_security_group_id = azurerm_network_security_group.nsgname.id
}
