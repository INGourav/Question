data "azurerm_network_security_group" "example" {
  name                = "Test-NSG"
  resource_group_name = "${data.azurerm_resource_group.vnet.name}"
}