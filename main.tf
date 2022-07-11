# ARM template for Service Bus subscription
data "template_file" "subscription_template" {
  template = file("${path.module}/template/subscription_template.json")
}

# Create Azure Service Bus subscription
resource "azurerm_template_deployment" "subscription" {
  template_body       = "${data.template_file.subscription_template.rendered}"
  name                = "${var.name}"
  deployment_mode     = "Incremental"
  resource_group_name = "${var.resource_group_name}"

  parameters = {
    serviceBusNamespaceName       = "${var.namespace_name}"
    serviceBusTopicName           = "${var.topic_name}"
    serviceBusSubscriptionName    = "${var.name}"
    lockDuration                  = "${var.lock_duration}"
    maxDeliveryCount              = "${var.max_delivery_count}"
    forwardTo                     = "${var.forward_to}"
    forwardDeadLetteredMessagesTo = "${var.forward_dead_lettered_messages_to}"
    requiresSession               = "${var.requires_session}"
  }
}
