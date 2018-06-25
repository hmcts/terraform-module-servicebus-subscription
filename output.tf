output "name" {
  value = "${azurerm_template_deployment.subscription.name}"
}

output "path" {
  value = "${azurerm_template_deployment.subscription.parameters.serviceBusNamespaceName}/${azurerm_template_deployment.subscription.parameters.serviceBusTopicName}/${azurerm_template_deployment.subscription.parameters.serviceBusSubscriptionName}"
}
