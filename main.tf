# ARM template for Service Bus topic
data "template_file" "subscription_template" {
  template = "${file("${path.module}/template/subscription_template.json")}"
}

# Create Azure Service Bus topic
resource "azurerm_template_deployment" "subscription" {
  template_body       = "${data.template_file.subscription_template.rendered}"
  name                = "${var.name}"
  deployment_mode     = "Incremental"
  resource_group_name = "${var.resource_group_name}"

  parameters = {
    serviceBusNamespaceName     = "${var.namespace_name}"
    serviceBusTopicName         = "${var.topic_name}"
    serviceBusSubscriptionName  = "${var.name}"
    lockDuration                = "${var.lock_duration}"
    maxDeliveryCount            = "${var.max_delivery_count}"
  }
}
