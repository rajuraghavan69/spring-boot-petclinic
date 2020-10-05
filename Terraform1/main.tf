provider "azurerm" {
  version = ">= 2.0"
  features {}
}

# Azure resource group

resource "azurerm_resource_group" "rg_mqk" {
  name     = var.resource_group_name
  location = var.location
}

# Event Hubs

resource "azurerm_eventhub_namespace" "hubns" {
  name                     = "${var.resource_name_prefix}-hubns-${var.tag_env}"
  resource_group_name      = azurerm_resource_group.rg_mqk.name
  location                 = var.location
  sku                      = "Standard"
  capacity                 = var.eventhub_capacity
  auto_inflate_enabled     = true
  maximum_throughput_units = 20

  tags = {
    environment = var.tag_env
  }
}

# Consumer topic1

resource "azurerm_eventhub_1" "rcvr_topic_1" {
  name                = var.rcvr_topic_1
  namespace_name      = azurerm_eventhub_namespace.hubns.name
  resource_group_name = azurerm_eventhub_namespace.hubns.resource_group_name
  partition_count     = var.rcvr_topic_partition_count
  message_retention   = var.rcvr_topic_message_retention
}
# Consumer topic2

resource "azurerm_eventhub_2" "rcvr_topic_2" {
  name                = var.rcvr_topic_2
  namespace_name      = azurerm_eventhub_namespace.hubns.name
  resource_group_name = azurerm_eventhub_namespace.hubns.resource_group_name
  partition_count     = var.rcvr_topic_partition_count
  message_retention   = var.rcvr_topic_message_retention
}

resource "azurerm_eventhub_consumer_group" "group_rcvr_topic" {
  name                = var.rcvr_topic_consumer_group_name
  namespace_name      = azurerm_eventhub_namespace.hubns.name
  eventhub_name       = azurerm_eventhub_1.rcvr_topic_1.name
  eventhub_name       = azurerm_eventhub_2.rcvr_topic_2.name
  resource_group_name = azurerm_eventhub_namespace.hubns.resource_group_name
}
