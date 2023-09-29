
resource "azurerm_role_assignment" "mi_role_assignment_receiver" {
  principal_id         = var.managed_identity_object_id
  role_definition_name = "Azure Service Bus Data Receiver"
  scope                = azurerm_servicebus_subscription.servicebus_subscription.id

  count = var.managed_identity_object_id != null ? 1 : 0
}
