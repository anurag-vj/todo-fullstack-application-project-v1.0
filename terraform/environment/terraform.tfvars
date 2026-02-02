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
