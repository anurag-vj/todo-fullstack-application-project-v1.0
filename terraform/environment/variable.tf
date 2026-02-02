variable "subscription_id" {
  type      = string
  sensitive = true
  default   = "bd7b142b-030a-46e3-8a31-579ffb9d2046"
}

variable "address_space" {
  type    = list(string)
  default = ["10.10.10.0/24"]
}
