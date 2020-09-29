#variable "resource_name_prefix" {
#  type        = string
#  description = "Resource prefix"
#  default     = "kedaeh"
#}

# Tags
variable "tag_env" {
  type        = string
  description = "The environment tag name"
  default     = "dev"
}

variable resource_group_name {
  type        = string
  description = "Resource group name"
  default     = "keda-rg"
}

variable location {
  type        = string
  description = "Azure location where the infrastructure will be provisioned"
  default     = "eastus"
}

# Event Hubs (topics)
variable "rcvr_topic" {
  type        = string
  description = "Receiver topic name"
  default     = "receiver_topic"
}

# Event Hubs (capacity)
variable "eventhub_capacity" {
  description = "Event Hub namespace throughput capacity"
  default     = 2
}


# Event Hubs (consumer groups)
variable "rcvr_topic_consumer_group_name" {
  type        = string
  description = "Receiver topic consumer group name"
  default     = "group-receiver-topic"
}

# Event Hubs (partitions)
variable "rcvr_topic_partition_count" {
  description = "Event Hubs partition count for receiver_topic"
  default     = 10
}

# Event Hubs (message retention)
variable "rcvr_topic_message_retention" {
  description = "Event Hubs message retention for receiver_topic"
  default     = 1
}