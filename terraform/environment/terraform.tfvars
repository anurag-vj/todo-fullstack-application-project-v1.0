subnets = {
  fe-subnet = {
    name             = "$${local.name_pattern}-frontend-subnet"
    address_prefixes = ["10.10.10.0/27"]
  }
  be-subnet = {
    name             = "$${local.name_pattern}-backend-subnet"
    address_prefixes = ["10.10.10.32/27"]
  }
}

network_security_group = {
  "fe-nsg" = {
    name          = "$${local.name_pattern}-frontend-nsg"
    security_rule = ["22", "80"]
  }
  "be-nsg" = {
    name          = "$${local.name_pattern}-backend-nsg"
    security_rule = ["22", "8000"]
  }
}
