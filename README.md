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

## azurerm_servicebus_subscription_rule

The following example shows how to add a servicebus subscription rule:

```terraform
locals {
  sql_filters = {
    "hmc-servicebus-aat-subscription-rule-civil" : {
      sql_filter = "hmctsServiceId IN ('AAA7','AAA6')"
    }
  }

  correlation_filters = {
    correlation_filter1 : {
      properties = {
        hmctsProperty = "any"
      }
    }
  }
}
module "servicebus-subscription" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                = "hmc-to-civil-subscription"
  namespace_name      = "hmc-servicebus"
  topic_name          = "hmc-to-cft"
  resource_group_name = "hmc-shared"
  sql_filters         = local.sql_filters
  correlation_filters = local.correlation_filters
}
```

## Managed Identity Role Assignment
The following example shows how to give read access to a user assigned managed identity for the subscription:

```terraform
module "servicebus-subscription" {
  source                     = "git@github.com:hmcts/terraform-module-servicebus-subscription?ref=master"
  name                       = "your-subscription"
  namespace_name             = module.servicebus-namespace.name
  topic_name                 = module.servicebus-topic.name
  resource_group_name        = azurerm_resource_group.rg.name

  # this variable is required
  managed_identity_object_id = "your-mi-object-id"
}
```


<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>= 3.0.0)

## Resources

The following resources are used by this module:

- [azurerm_role_assignment.mi_role_assignment_receiver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_servicebus_subscription.servicebus_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) (resource)
- [azurerm_servicebus_subscription_rule.correlation_filter_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) (resource)
- [azurerm_servicebus_subscription_rule.sql_filter_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) (resource)
- [azurerm_servicebus_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/servicebus_topic) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: Azure Service Bus subscription name

Type: `string`

### <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name)

Description: Azure Service Bus namespace

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Resource group in which the Service Bus subscription should exist

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_correlation_filters"></a> [correlation\_filters](#input\_correlation\_filters)

Description: A map of correlation filters to create rules for which messages will be forwarded from the topic to the subscription. If left undefined or empty all messages will be forwarded. Defaults to {}.

Type:

```hcl
map(object({
    content_type        = optional(string)
    correlation_id      = optional(string)
    label               = optional(string)
    message_id          = optional(string)
    reply_to            = optional(string)
    reply_to_session_id = optional(string)
    session_id          = optional(string)
    to                  = optional(string)
    properties          = optional(map(string))
  }))
```

Default: `{}`

### <a name="input_forward_dead_lettered_messages_to"></a> [forward\_dead\_lettered\_messages\_to](#input\_forward\_dead\_lettered\_messages\_to)

Description: Topic or Queue to forwards dead lettered messages to

Type: `string`

Default: `""`

### <a name="input_forward_to"></a> [forward\_to](#input\_forward\_to)

Description: Topic or Queue to forwards received messages to

Type: `string`

Default: `""`

### <a name="input_lock_duration"></a> [lock\_duration](#input\_lock\_duration)

Description: Message lock duration (ISO-8601)

Type: `string`

Default: `"PT1M"`

### <a name="input_managed_identity_object_id"></a> [managed\_identity\_object\_id](#input\_managed\_identity\_object\_id)

Description: the object id of the managed identity - can be retrieved with az identity show --name <identity-name>-sandbox-mi -g managed-identities-<env>-rg --subscription DCD-CFTAPPS-<env> --query principalId -o tsv

Type: `any`

Default: `null`

### <a name="input_max_delivery_count"></a> [max\_delivery\_count](#input\_max\_delivery\_count)

Description: Maximum number of attempts to deliver a message before it's sent to dead letter queue

Type: `number`

Default: `10`

### <a name="input_requires_session"></a> [requires\_session](#input\_requires\_session)

Description: A value that indicates whether the queue supports the concept of sessions

Type: `bool`

Default: `false`

### <a name="input_sql_filters"></a> [sql\_filters](#input\_sql\_filters)

Description: A map of sql filters

Type:

```hcl
map(object({
    sql_filter = optional(string)
  }))
```

Default: `{}`

### <a name="input_topic_id"></a> [topic\_id](#input\_topic\_id)

Description: Azure Service Bus topic resource ID. When provided, topic\_name/namespace\_name/resource\_group\_name are not used for the subscription resource.

Type: `string`

Default: `null`

### <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name)

Description: Azure Service Bus topic name (required when use\_topic\_id is false)

Type: `string`

Default: `null`

### <a name="input_use_topic_id"></a> [use\_topic\_id](#input\_use\_topic\_id)

Description: When true, topic\_id is used instead of topic\_name/namespace\_name/resource\_group\_name.

Type: `bool`

Default: `false`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output\_id)

Description: n/a

### <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id)

Description: n/a

### <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name)

Description: n/a
<!-- END_TF_DOCS -->