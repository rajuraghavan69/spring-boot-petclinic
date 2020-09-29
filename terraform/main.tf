provider "azurerm" {
  version = ">= 2.0"
  features {}
}

# Azure resource group

resource "azurerm_resource_group" "rg_keda" {
  name     = var.resource_group_name
  location = var.location
}

# Azure container registry

resource "azurerm_container_registry" "acr" {
  name                = "${var.resource_name_prefix}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
}

# AKS cluster


resource "azurerm_role_assignment" "acrpull_role_aks_app" {
  scope                            = azurerm_resource_group.rg_keda.id
  role_definition_name             = "AcrPull"
  principal_id                     = var.service_principal_client_id
  skip_service_principal_aad_check = true
}

#

# Event Hubs

resource "azurerm_eventhub_namespace" "hubns" {
  name                     = "${var.resource_name_prefix}-hubns-${var.tag_env}"
  resource_group_name      = azurerm_resource_group.rg_keda.name
  location                 = var.location
  sku                      = "Standard"
  capacity                 = var.eventhub_capacity
  auto_inflate_enabled     = true
  maximum_throughput_units = 20

  tags = {
    environment = var.tag_env
  }
}

# Consumer topic

resource "azurerm_eventhub" "rcvr_topic" {
  name                = var.rcvr_topic
  namespace_name      = azurerm_eventhub_namespace.hubns.name
  resource_group_name = azurerm_eventhub_namespace.hubns.resource_group_name
  partition_count     = var.rcvr_topic_partition_count
  message_retention   = var.rcvr_topic_message_retention
}

resource "azurerm_eventhub_consumer_group" "group_rcvr_topic" {
  name                = var.rcvr_topic_consumer_group_name
  namespace_name      = azurerm_eventhub_namespace.hubns.name
  eventhub_name       = azurerm_eventhub.rcvr_topic.name
  resource_group_name = azurerm_eventhub_namespace.hubns.resource_group_name
}
