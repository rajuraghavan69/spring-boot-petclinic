
# Outputs required for deploy.yaml

output "eventhub_namespace_conn_string_base64encoded" {
  value = base64encode(azurerm_eventhub_namespace.hubns.default_primary_connection_string) 
}

output "eventhub_namespace_name_base64encoded" {
  value = base64encode(azurerm_eventhub_namespace.hubns.name)
}

output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.hubns.name
}

output "eventhub_consumergroup_name_base64encoded"{
  value = base64encode(azurerm_eventhub_consumer_group.group_rcvr_topic.name)
}

output "eventhub_consumergroup_name"{
  value = azurerm_eventhub_consumer_group.group_rcvr_topic.name
}

output "eventhub_name_base64encoded" {
  value = base64encode(azurerm_eventhub.rcvr_topic.name)
}

output "eventhub_name" {
  value = azurerm_eventhub.rcvr_topic.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg_keda.name
}
