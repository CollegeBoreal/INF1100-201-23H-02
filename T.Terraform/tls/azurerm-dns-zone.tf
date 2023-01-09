resource "azurerm_resource_group" "resource_group" {
  name     = "zone-dns-CB-AZ-300000000"
  location = var.location
}

resource "azurerm_dns_zone" "base_domain" {
  name = var.domain
  resource_group_name = azurerm_resource_group.resource_group.name
}
