output "subscription_id" { value = var.subscription_id }
output "resource_group"  { value = azurerm_resource_group.rg.name }
output "aks_name"        { value = azurerm_kubernetes_cluster.aks.name }
output "acr_login_server"{ value = azurerm_container_registry.acr.login_server }
output "acr_name"        { value = azurerm_container_registry.acr.name }
output "kube_config"     { value = azurerm_kubernetes_cluster.aks.kube_config_raw, sensitive = true }
