# Create virtual machine
resource "azurerm_virtual_machine" "myterraformvm" {
    count                            = length(var.vm_names)
    name                             = "${var.vm_names}[count.index]"
    location                         = "${var.location}"
    resource_group_name              = "${data.azurerm_resource_group.net.name}"
    network_interface_ids            = [azurerm_network_interface.myterraformnic.id[count.index]]
    vm_size                          = "Standard_D8_v3"
    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true

  source_image_reference {
        publisher       = "OpenLogic"
        offer           = "CentOS"
        sku             = "7.7"
        version         = "latest"
    }

    storage_os_disk {
        count                = length(var.vm_names)
        name                 = "${var.vm_name}-osdisk[count.index]"
        caching              = "ReadWrite"
        create_option        = "FromImage"
        disk_size_gb         = 32
        managed_disk_type    = "Premium_LRS"
        
    }
    
    storage_data_disk {
      count                     = length(var.vm_names)
      name                      = "${var.vm_name}-disk1[count.index]"
      caching                   = "None"
      create_option             = "Empty"
      disk_size_gb              = 512
      lun                       = 0
      managed_disk_type         = "Premium_LRS"
  }

     os_profile {
      computer_name  = "${var.vm_name}"
      admin_username = "${var.vm_name}-adm"
      admin_password = "${random_string.password.result}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

    boot_diagnostics {
        enabled       = "true"
        storage_uri   = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
    }

    tags = {
        Environment = var.environment
        BuildBy     = var.tag_buildby
        BuildTicket = var.tag_buildticket
        BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
    }
}