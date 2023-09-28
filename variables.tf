variable "name" {
  type        = string
  description = "Azure Service Bus subscription name"
}

variable "namespace_name" {
  type        = string
  description = "Azure Service Bus namespace"
}

variable "topic_name" {
  type        = string
  description = "Azure Service Bus topic name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which the Service Bus subscription should exist"
}

variable "max_delivery_count" {
  type        = number
  description = "Maximum number of attempts to deliver a message before it's sent to dead letter queue"
  default     = 10
}

variable "lock_duration" {
  type        = string
  description = "Message lock duration (ISO-8601)"
  default     = "PT1M"
}

variable "forward_to" {
  type        = string
  description = "Topic or Queue to forwards received messages to"
  default     = ""
}

variable "forward_dead_lettered_messages_to" {
  type        = string
  description = "Topic or Queue to forwards dead lettered messages to"
  default     = ""
}

variable "requires_session" {
  type        = bool
  description = "A value that indicates whether the queue supports the concept of sessions"
  default     = false
}

variable "managed_identity_object_ids" {
  type    = list(string)
  default = []
}

variable "managed_identity_object_id" {
  default     = ""
  description = "the object id of the managed identity - can be retrieved with az identity show --name <identity-name>-sandbox-mi -g managed-identities-<env>-rg --subscription DCD-CFTAPPS-<env> --query principalId -o tsv"
}