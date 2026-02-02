variable "subscription_id" {
  type      = string
  sensitive = true
  default   = "bd7b142b-030a-46e3-8a31-579ffb9d2046"
}

variable "address_space" {
  type = list(string)
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
