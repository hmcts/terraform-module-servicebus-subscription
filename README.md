# terraform-module-servicebus-subscription

A Terraform module for creating Azure Service Bus subscription
Refer to the following link for a detailed explanation of the Azure Service Bus subscription.

[Azure Service Bus Subscription](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-queues-topics-subscriptions)

## Usage

The following example shows how to use the module to create an Azure Service Bus subscription. 

```terraform
module "servicebus-subscription" {
  source                = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                  = "your-subscription"
  namespace_name        = module.servicebus-namespace.name
  topic_name            = module.servicebus-topic.name
  resource_group_name   = azurerm_resource_group.rg.name
}
```

## Variables

### Configuration

The following parameters are required by this module

- `name` the name of the ServiceBus namespace.
- `resource_group_name` the name of the resource group in which to create the ServiceBus namespace.
- `namespace_name` the name of the service bus namespace in which the subscription must be created.
- `topic_name` the name of the service bus topic in which the subscription must be created.

The following parameters are optional

- `max_delivery_count` the maximum number of deliveries. Default is 10.
- `lock_duration` the lock duration for the subscription as an ISO 8601 duration. Default is PT1M.
- `forward_to` the name of a Queue or Topic to automatically forward messages to.
- `forward_dead_lettered_messages_to` the name of a Queue or Topic to automatically forward Dead Letter messages to.
