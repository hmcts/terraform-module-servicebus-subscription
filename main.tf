resource "azurerm_servicebus_subscription" "servicebus_subscription" {
  name                = var.name
  resource_group_name = var.resource_group_name
  namespace_name      = var.namespace_name
  topic_name          = var.topic_name

  lock_duration                     = var.lock_duration
  max_delivery_count                = var.max_delivery_count
  forward_to                        = var.forward_to
  forward_dead_lettered_messages_to = var.forward_dead_lettered_messages_to

  requires_session                     = false
  dead_lettering_on_message_expiration = true
  enable_batched_operations            = true
  default_message_ttl                  = "P10675199DT2H48M5.477S"
  auto_delete_on_idle                  = "P10675198DT2H48M5.477S"
}