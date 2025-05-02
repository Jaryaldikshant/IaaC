

# VIRTUAL NETWORK
resource "azurerm_virtual_network" "main" {
  name                = "${var.env}-network"

  address_space       = ["10.0.0.0/16"]

  location            = azurerm_resource_group.state.location

  resource_group_name = azurerm_resource_group.state.name
}

# SUBNET
resource "azurerm_subnet" "internal" {

  name                 = "internal"

  resource_group_name  = azurerm_resource_group.state.name

  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes     = ["10.0.2.0/24"]
}

# NETWORK SECURITY GROUP
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.env}-nsg"

  location            = azurerm_resource_group.state.location

  resource_group_name = azurerm_resource_group.state.name

  # rules to allow SSH access (port 22)
  security_rule {
    name                       = "allow_ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # rules to allow HTTP access (port 80)
  security_rule {
    name                       = "allow_http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# ASSOCIATE NSG TO SUBNET
resource "azurerm_subnet_network_security_group_association" "nsg_association" {

  subnet_id                 = azurerm_subnet.internal.id

  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [ azurerm_network_security_group.nsg,azurerm_subnet.internal ]

 
}



# PUBLIC IP
resource "azurerm_public_ip" "public_ip" {


    count = var.vm_count

    name                = "${var.env}-public-ip-${count.index}"

    location            = azurerm_resource_group.state.location

    resource_group_name = azurerm_resource_group.state.name

    allocation_method   = "Static"

    domain_name_label   = "${var.env}-vm-pip-${count.index}"
}



# NETWORK INTERFACE
resource "azurerm_network_interface" "main" {

 count = var.vm_count

    name                = "${var.env}-nic-${count.index}"

    location            = azurerm_resource_group.state.location

    resource_group_name = azurerm_resource_group.state.name

    
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    
    public_ip_address_id = azurerm_public_ip.public_ip[count.index].id

  }
}

# VIRTUAL MACHINE
resource "azurerm_virtual_machine" "main" {
    count = var.vm_count
    name                  =  "${var.vm_name}-${count.index}"


    location            = azurerm_resource_group.state.location

    resource_group_name = azurerm_resource_group.state.name

    network_interface_ids = [azurerm_network_interface.main[count.index].id]

    vm_size               = var.vm_size


  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  storage_os_disk {
    name              = "myosdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  =  "${var.vm_name}-${count.index}"

    admin_username = var.username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.username}/.ssh/authorized_keys"
      key_data = file("infra-app/ssh_Key.pub")
    }

    
  }
  

 tags = {
        name = "${var.env}-infra-app-vm"
        environment = var.env
    }
}


