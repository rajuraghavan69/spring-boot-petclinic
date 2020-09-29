provider "azurerm" {
  version = ">= 2.0"
  features {}
}

# Azure resource group

resource "azurerm_resource_group" "rg_keda" {
  name     = var.resource_group_name
  location = var.location
}


# Event Hubs

resource "azurerm_eventhub_namespace" "hubns" {
  name                     = "mkqeventhub"
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
