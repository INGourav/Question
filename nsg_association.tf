# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = "${azurerm_network_interface.myterraformnic.id}"
    network_security_group_id = "${data.azurerm_network_security_group.example.id}"
}