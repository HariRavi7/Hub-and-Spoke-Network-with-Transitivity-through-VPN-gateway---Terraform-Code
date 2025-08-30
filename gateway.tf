
# GatewaySubnet inside the Hub
resource "azurerm_subnet" "hub_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = var.virtual_network_properties["Hub_vnet"].vnet_name
  address_prefixes     = ["10.5.0.0/27"]
}

resource "azurerm_public_ip" "hub_gw_pip" {
  name                = "hub-vpn-gw-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network_gateway" "hub_vpn_gw" {
  name                = "hub-vpn-gateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"

  ip_configuration {
    name                          = "vpngw-ipconf"
    public_ip_address_id          = azurerm_public_ip.hub_gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub_gateway.id
  }
}
