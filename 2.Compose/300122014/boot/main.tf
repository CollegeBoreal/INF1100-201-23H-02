resource "azurerm_resource_group" "CB-AZ-300122014" {
  name     = "ressources-CB-AZ-300122014"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "CB-AZ-300122014" {
  name                = "reseau-CB-AZ-300122014"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.CB-AZ-300122014.location
  resource_group_name = azurerm_resource_group.CB-AZ-300122014.name
}

resource "azurerm_subnet" "CB-AZ-300122014" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.CB-AZ-300122014.name
  virtual_network_name = azurerm_virtual_network.CB-AZ-300122014.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Adresse publique
resource "azurerm_public_ip" "CB-AZ-300122014" {
  name                = "ip-CB-AZ-300122014"
  location            = azurerm_resource_group.CB-AZ-300122014.location
  resource_group_name = azurerm_resource_group.CB-AZ-300122014.name
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

# CIR (NIC en Anglais) Carte d'Interface Reseau
resource "azurerm_network_interface" "CB-AZ-300122014" {
  name                = "cir-CB-AZ-300122014"
  location            = azurerm_resource_group.CB-AZ-300122014.location
  resource_group_name = azurerm_resource_group.CB-AZ-300122014.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.CB-AZ-300122014.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.CB-AZ-300122014.id}"
  }
}

# Groupe Securite (SG en Anglais)
resource "azurerm_network_security_group" "CB-AZ-300122014" {
  name                = "gs-CB-AZ-300122014"
  location            = azurerm_resource_group.CB-AZ-300122014.location
  resource_group_name = azurerm_resource_group.CB-AZ-300122014.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DOCKER"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2376"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/config/cloud-config.yml", {
      header: azurerm_network_security_group.CB-AZ-300122014.id
    })
  }
}

resource "azurerm_linux_virtual_machine" "CB-AZ-300122014" {
  name                = "machine-CB-AZ-300122014"
  resource_group_name = azurerm_resource_group.CB-AZ-300122014.name
  location            = azurerm_resource_group.CB-AZ-300122014.location
  size                = "Standard_B2s"
  admin_username      = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.CB-AZ-300122014.id,
  ]

  # This is where we pass our cloud-init.
  custom_data = data.template_cloudinit_config.config.rendered

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/10.13.237.28.pub ")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-confidential-vm-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202110290"
  }

}

data "azurerm_public_ip" "CB-AZ-300122014" {
  name                = "${azurerm_public_ip.CB-AZ-300122014.name}"
  resource_group_name = "${azurerm_linux_virtual_machine.CB-AZ-300122014.resource_group_name}"
}

output "public_ip_address" {
  value = "${data.azurerm_public_ip.CB-AZ-300122014.ip_address}"
}
