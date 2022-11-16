data "azurerm_resource_group" "aksrg" {
  name = var.resource_group
}

resource "azurerm_kubernetes_cluster" "aks" {
    name                = var.clustername
    location            = var.locationk8s
    resource_group_name = data.azurerm_resource_group.aksrg.name
    dns_prefix          = var.dns_prefix

    default_node_pool {
        name            = "default"
        node_count      = 1
        vm_size         = "Standard_B2s"
        os_disk_size_gb = 30
    }
    identity {
        type = "SystemAssigned"
    }
    
    tags = {
        Environment = "Test"
    }
}
