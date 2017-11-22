resource "azurerm_servicebus_subscription" "subscription" {
  name                = "${var.name}"
  resource_group_name = "${var.resource_group_name}"
  namespace_name      = "${var.namespace_name}"
  topic_name          = "${var.topic_name}"
  max_delivery_count  = "${var.max_delivery_count}"
  lock_duration       = "${var.lock_duration}"
}
