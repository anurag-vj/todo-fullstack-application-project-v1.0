subnets = {
  "fe-subnet" = {
    name             = "$${local.name_prefix}-frontend-subnet"
    address_prefixes = ["10.10.10.0/27"]
  }
  "be-subnet" = {
    name             = "$${local.name_prefix}-backend-subnet"
    address_prefixes = ["10.10.10.32/27"]
  }
}

network_security_group = {
  "fe-nsg" = {
    name          = "$${local.name_prefix}-frontend-nsg"
    security_rule = ["22", "80"]
  }
  "be-nsg" = {
    name          = "$${local.name_prefix}-backend-nsg"
    security_rule = ["22", "8000"]
  }
}

subnet_nsg = {
  "fe-subet-fe-nsg" = {
    subnet_key = "fe-subnet"
    nsg_key    = "fe-nsg"
  }
  "be-subnet-be-nsg" = {
    subnet_key = "be-subnet"
    nsg_key    = "be-nsg"
  }
}

public_ip = {
  "fe-pip" = {
    name              = "$${local.name_prefix}-frontend-pip"
    allocation_method = "Dynamic"
  }
  "be-pip" = {
    name              = "$${local.name_prefix}-backend-pip"
    allocation_method = "Dynamic"
  }
}

network_interface = {
  "fe-nic" = {
    name                         = "$${local.name_prefix}-frontend-nic"
    subnet_key                   = "fe-subnet"
    public_ip_address_allocation = "Dynamic"
    public_ip_address            = true
    public_ip_key                = "fe-pip"
  }
  "be-nic" = {
    name                         = "$${local.name_prefix}-backend-nic"
    subnet_key                   = "be-subnet"
    public_ip_address_allocation = "Dynamic"
    public_ip_address            = true
    public_ip_key                = "be-pip"
  }
}

linux_virtual_machine = {
  "fe-vm" = {
    name                  = "$${local.name_prefix}-frontend-vm"
    size                  = "Standard_B2s"
    network_interface_key = "fe-nic"
    offer                 = "0001-com-ubuntu-server-jammy"
    sku                   = "22_04-LTS"
  }
  "be-vm" = {
    name                  = "$${local.name_prefix}-backend-vm"
    size                  = "Standard_B2s"
    network_interface_key = "be-nic"
    offer                 = "0001-com-ubuntu-server-focal"
    sku                   = "20_04-LTS"
  }
}
