locals {
  #mentioning spokes to connect from spoke to vnet
  spokes = {
    vnet1 = var.virtual_network_properties["vnet1"]
    vnet2 = var.virtual_network_properties["vnet2"]
    vnet3 = var.virtual_network_properties["vnet3"]
    vnet4 = var.virtual_network_properties["vnet4"]
    vnet5 = var.virtual_network_properties["vnet5"]
  }
}


resource "azurerm_virtual_network_peering" "spokes" {

  for_each                  = local.spokes
  name                      = "${each.key}-to-hub-connection"
  resource_group_name       = azurerm_resource_group.rg.name
  use_remote_gateways       = true #hub is the remote gateway in this case. so we need to use the hub
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false #false for spoke to hub since the hub acts like a router between vpn/firewall and vnet 
  virtual_network_name      = each.value.vnet_name
  remote_virtual_network_id = azurerm_virtual_network.vnet["Hub_vnet"].id
}

resource "azurerm_virtual_network_peering" "hub" {

  for_each                  = local.spokes
  name                      = "Hub-to-${each.value.vnet_name}-connection"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = "Hub-vnet"
  allow_gateway_transit     = true #hub acts like intermediarry between the spokes and the gateway that acts like a router
  allow_forwarded_traffic   = true
  use_remote_gateways       = false #hub itself is a remote gateway, so we are not using any
  remote_virtual_network_id = azurerm_virtual_network.vnet[each.value.vnet_name].id
}
