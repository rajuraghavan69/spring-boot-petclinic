# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}
resource "azurerm_resource_group" "mqktest" {
  name     = "atos-connector"
  location = "Southeast Asia"
}

resource "azurerm_eventhub_namespace" "mqkconnector" {
  name                = "mqk-namespace"
  location            = azurerm_resource_group.mqktest.location
  resource_group_name = azurerm_resource_group.mqktest.name
  sku                 = "Standard"
  capacity            = 12
  auto_inflate_enabled = true
  tags = {
    environment = "Production"
  }
}
resource "azurerm_eventhub" "providertesttpk1" {
  name                = "providerTestTopic1"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  resource_group_name = azurerm_resource_group.mqktest.name
  partition_count     = 5
  message_retention   = 7
}
resource "azurerm_eventhub" "providertesttpk2" {
  name                = "providerTestTopic2"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  resource_group_name = azurerm_resource_group.mqktest.name
  partition_count     = 5
  message_retention   = 7
}
resource "azurerm_eventhub" "providertesttpk3" {
  name                = "providerTestTopic3"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  resource_group_name = azurerm_resource_group.mqktest.name
  partition_count     = 5
  message_retention   = 7
}
resource "azurerm_eventhub" "providertesttpk4" {
  name                = "providerTestTopic4"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  resource_group_name = azurerm_resource_group.mqktest.name
  partition_count     = 5
  message_retention   = 7
}

resource "azurerm_eventhub_consumer_group" "hcaas1" {
  name                = "testConsumerGroup"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  eventhub_name       = azurerm_eventhub.providertesttpk1.name
  resource_group_name = azurerm_resource_group.mqktest.name
  user_metadata       = "some-meta-data-1"
}

resource "azurerm_eventhub_consumer_group" "hcaas2" {
  name                = "testConsumerGroup"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  eventhub_name       = azurerm_eventhub.providertesttpk2.name
  resource_group_name = azurerm_resource_group.mqktest.name
  user_metadata       = "some-meta-data-2"
}
resource "azurerm_eventhub_consumer_group" "hcaas3" {
  name                = "testConsumerGroup"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  eventhub_name       = azurerm_eventhub.providertesttpk3.name
  resource_group_name = azurerm_resource_group.mqktest.name
  user_metadata       = "some-meta-data-3"
}
resource "azurerm_eventhub_consumer_group" "hcaas4" {
  name                = "testConsumerGroup"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  eventhub_name       = azurerm_eventhub.providertesttpk4.name
  resource_group_name = azurerm_resource_group.mqktest.name
  user_metadata       = "some-meta-data-4"
}