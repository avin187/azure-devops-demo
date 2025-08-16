locals {
  rg_name  = "${var.name_prefix}-rg"
  acr_name = replace("${var.name_prefix}acr", "/[^a-z0-9]/", "")
  aks_name = "${var.name_prefix}-aks"
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name_prefix}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.name_prefix}-dns"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                 = "systemnp"
    vm_size              = var.node_size
    enable_auto_scaling  = true
    min_count            = 2
    max_count            = 4
    orchestrator_version = var.kubernetes_version
    node_labels = { workload = "general" }
  }

  identity { type = "SystemAssigned" }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  sku_tier = "Free"
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
