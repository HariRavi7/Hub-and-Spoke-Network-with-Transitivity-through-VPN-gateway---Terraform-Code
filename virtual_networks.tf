

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_network_properties
  name                = each.value.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = each.value.vnet_address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    "virtual_network_name" = "${each.value.vnet_name}"
  }
}
