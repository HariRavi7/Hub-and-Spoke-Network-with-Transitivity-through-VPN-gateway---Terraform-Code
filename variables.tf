variable "subscription_id" {
  description = "value of the subscription in which vnets are created"
  type        = string #pass through tfvars

}

variable "virtual_network_properties" {
  type = map(object({
    vnet_name          = string
    vnet_address_space = set(string)
  }))
  default = {
    "vnet1" = {
      vnet_name          = "vnet1"
      vnet_address_space = ["10.0.0.0/24"]
    }
    "vnet2" = {
      vnet_name          = "vnet2"
      vnet_address_space = ["10.1.0.0/24"]
    }
    "vnet3" = {
      vnet_name          = "vnet3"
      vnet_address_space = ["10.2.0.0/24"]
    }
    "vnet4" = {
      vnet_name          = "vnet4"
      vnet_address_space = ["10.3.0.0/24"]
    }
    "vnet5" = {
      vnet_name          = "vnet5"
      vnet_address_space = ["10.4.0.0/24"]
    }
    "Hub_vnet" = {
      vnet_name          = "Hub-vnet"
      vnet_address_space = ["10.5.0.0/24"]
    }
  }
}

