variable "name" {
  type = "string"
  description = "Azure Service Bus subscription name"
}

variable "namespace_name" {
  type = "string"
  description = "Azure Service Bus namespace"
}

variable "topic_name" {
  type = "string"
  description = "Azure Service Bus topic name"
}

variable "resource_group_name" {
  type = "string"
  description = "Resource group in which the Service Bus subscription should exist"
}

variable "max_delivery_count" {
  type = "string"
  description = "Subscription's maxium delivery count for messages"
  default = "10"
}

variable "lock_duration" {
  type = "string"
  description = "Message lock duration"
  default = "00:01:00"
}
