
# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    count                     = length(var.vm_names)
    name                      = "${var.vm_names}[count.index]"
    location                  = "${var.location}"
    resource_group_name       = "${data.azurerm_resource_group.net.name}"

    ip_configuration {
        name                          = "ipconfig1"
        subnet_id                     = "${data.azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "Dynamic"
    }
}
