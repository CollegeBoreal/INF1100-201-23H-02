resource "azurerm_resource_group" "AKS-CB-AZ-300121460" {
  name     = "AKS-CB-AZ-300121460-rg"
  location = "Canada Central"

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_kubernetes_cluster" "AKS-CB-AZ-300121460" {
  name                = "AKS-CB-AZ-300121460-aks"
  location            = azurerm_resource_group.AKS-CB-AZ-300121460.location
  resource_group_name = azurerm_resource_group.AKS-CB-AZ-300121460.name
  dns_prefix          = "AKS-CB-AZ-300121460-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Dev"
  }
}
