resource "azurerm_kubernetes_cluster" "main" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = "roboshop"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2as_v2"
    vnet_subnet_id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
  }

  identity {
    type = "SystemAssigned"
  }

  aci_connector_linux {
    subnet_name = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
  }

  network_profile {
    network_plugin = "azure"
    service_cidr = "10.100.0.0/24"
    dns_service_ip = "10.100.0.10"
  }
}
