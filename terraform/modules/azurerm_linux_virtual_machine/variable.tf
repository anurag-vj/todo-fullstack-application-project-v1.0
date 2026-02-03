variable "virtual_machine_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "network_interface_ids" {
  type = list(string)
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "tags" {
  type    = map(string)
  default = {}
}
