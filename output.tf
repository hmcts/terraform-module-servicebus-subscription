output "name" {
  value = "${azurerm_template_deployment.subscription.name}"
}

output "path" {
  value = "${azurerm_template_deployment.subscription.outputs["resourceId"]}"
}
