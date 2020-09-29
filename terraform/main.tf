# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}
resource "azurerm_resource_group" "mqktest" {
  name     = "atos-connector"
  location = "eastus"
}

resource "azurerm_eventhub_namespace" "mqkconnector" {
  name                = "mqk-namespace"
  location            = azurerm_resource_group.mqktest.location
  resource_group_name = azurerm_resource_group.mqktest.name
  sku                 = "Standard"
  capacity            = 2

  tags = {
    environment = "Production"
  }
}
resource "azurerm_eventhub" "providertesttpk" {
  name                = "providerTestTopic"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  resource_group_name = azurerm_resource_group.mqktest.name
  partition_count     = 2
  message_retention   = 2
}

resource "azurerm_eventhub_consumer_group" "hcaas1" {
  name                = "acceptanceTestEventHubConsumerGroup"
  namespace_name      = azurerm_eventhub_namespace.mqkconnector.name
  eventhub_name       = azurerm_eventhub.providertesttpk.name
  resource_group_name = azurerm_resource_group.mqktest.name
  user_metadata       = "some-meta-data"
}