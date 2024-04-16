variable "vmname" {
  description = "Virutal Machine Name"
}

variable "admin_username" {
  description = "Admin user name"
}


variable "admin_password" {
  description = "Admin password"
}

variable "size" {
  description = "Size of the VM"
}
variable "disk_cache" {
  description = "OS Disc Cache"
}

variable "disk_storage_account_type" {
  description = "Storage account type"
}


variable "publisher" {
  description = "Publisher"
}


variable "offer" {
  description = "Offer"
}

variable "sku" {
  description = "SKU"
}

variable "os_version" {
  description = "OS Version"
}


variable "rgname" {
  description = "RG NAME"
}
variable "rg_loc" {
  description = "RG Location"
}

variable "vm_nic_id" {
  type        = list(string)
  description = "NIC for Virtual Machine"
}

variable "nsgname" {
  description = "NSG Name"
}

variable "nsgrules" {
  description = "ngsRules"
}

# variable "var_nsgid" {
#   description = "NSG ID"
# }
