output "cluster_username" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.username
    sensitive = true
}

output "host" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.host
    sensitive = true
}