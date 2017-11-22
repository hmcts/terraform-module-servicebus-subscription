output "servicebus_subscription" {
  value = "${azurerm_servicebus_subscription.subscription.name}"
}
