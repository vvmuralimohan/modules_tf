module "vnet" {
  source               = "./module/Network"
  vnet_name            = "main_vnet"
  resource_group_name  = azurerm_resource_group.example.name
  vnet_address         = ["10.0.0.0/16"]
  vnet_loc             = azurerm_resource_group.example.location
  internal_subnet      = "internal"
  internal_subnet_cidr = ["10.0.1.0/24"]
}

module "netwrk_interface_ids" {
  source            = "./module/network-interface"
  vm_nic_name       = "linuxvm_nic"
  publicip_name     = "linuxvm_publicip"
  internal_subnetid = module.vnet.subnet_id
  rgname            = azurerm_resource_group.example.name
  rg_loc            = azurerm_resource_group.example.location
}


module "linuxvm" {
  source                    = "./module/virutalmachine"
  vmname                    = "Test-Linux"
  rgname                    = azurerm_resource_group.example.name
  rg_loc                    = azurerm_resource_group.example.location
  size                      = "Standard_F2"
  admin_username            = "adminuser"
  admin_password            = "P@ssw0rd1234"
  vm_nic_id                 = [module.netwrk_interface_ids.vm_nicid]
  disk_cache                = "ReadWrite"
  disk_storage_account_type = "Standard_LRS"
  publisher                 = "Canonical"
  offer                     = "0001-com-ubuntu-server-jammy"
  sku                       = "22_04-lts"
  os_version                = "latest"
  nsgname                   = "nsg"
  nsgrules                  = local.nsgrules10  
}


locals {
  nsgrules10 = {

    ssh = {
      name                       = "ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    sql = {
      name                       = "sql"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    http = {
      name                       = "http"
      priority                   = 201
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}