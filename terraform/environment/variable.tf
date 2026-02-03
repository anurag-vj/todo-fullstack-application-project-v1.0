variable "subscription_id" {
  type      = string
  sensitive = true
  default   = "bd7b142b-030a-46e3-8a31-579ffb9d2046"
}

variable "address_space" {
  type    = list(string)
  default = ["10.10.10.0/24"]
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "network_security_group" {
  type = map(object({
    name          = string
    security_rule = list(string)
  }))
}

variable "subnet_nsg" {
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "public_ip" {
  type = map(object({
    name              = string
    allocation_method = string
  }))
}

variable "network_interface" {
  type = map(object({
    name                         = string
    subnet_key                   = string
    public_ip_address_allocation = string
    public_ip_address            = bool
    public_ip_key                = optional(string)
  }))
}

variable "linux_virtual_machine" {
  type = map(object({
    name                  = string
    size                  = string
    network_interface_key = string
    offer                 = string
    sku                   = string
  }))
}

variable "mssql_server_version" {
  type    = string
  default = "12.0"
}
