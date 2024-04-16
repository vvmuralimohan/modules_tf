variable "vnet_name" {
    description = "VNet Name"  
}

variable "vnet_address" {
    type = list(string)
    description = "VNet Address Space"  
}

variable "internal_subnet" {
    description = "Internal Subnet Name"  
}

variable "internal_subnet_cidr" {
    type = list(string)
    description = "Internal Subnet CIDR"  
}

variable "vnet_loc" {
    description = "VNet Location"  
}

variable "resource_group_name" {
    description = "Resource Group Name"  
}