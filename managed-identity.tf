locals {
  managed_identity_list = toset(compact(concat(var.managed_identity_object_ids, [var.managed_identity_object_id])))
}

resource "azurerm_user_assigned_identity" "managed_identity" {
  resource_group_name = "managed-identities-${var.env}-rg"
  location            = var.location
  name                = "${var.product}-${var.env}-mi"

  count = var.create_managed_identity ? 1 : 0
}

resource "azurerm_role_assignment" "implicit_mi_role_assignment_receiver" {
  principal_id         = azurerm_user_assigned_identity.managed_identity[0].principal_id
  role_definition_name = "Azure Service Bus Data Receiver"
  scope                = azurerm_servicebus_subscription.servicebus_subscription.id
  count                = var.create_managed_identity ? 1 : 0
}

resource "azurerm_role_assignment" "mi_role_assignment_receiver" {
  principal_id         = each.value
  role_definition_name = "Azure Service Bus Data Receiver"
  scope                = azurerm_servicebus_subscription.servicebus_subscription.id
  for_each             = local.managed_identity_list
}
