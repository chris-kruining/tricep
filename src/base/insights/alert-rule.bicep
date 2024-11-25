import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func alert_rule(context Context, name string, isEnabled bool, condition RuleCondition, options Options) object =>
  create_resource(
    context,
    'appConfiguration',
    union(
      [
        {}
      ],
      options
    )
  )

@export()
type AlertRule = {
  @description('action that is performed when the alert rule becomes active, and when an alert condition is resolved.')
  action: RuleAction?

  @description('the array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.')
  actions: RuleAction[]?

  @description('the condition that results in the alert rule being activated.')
  condition: RuleCondition

  @description('the description of the alert rule that will be included in the alert email.')
  description: string?

  @description('the flag that indicates whether the alert rule is enabled.')
  isEnabled: bool

  @description('the name of the alert rule.')
  name: string

  @description('the provisioning state.')
  provisioningState: string?
}

@export()
@discriminator('odata.type')
type RuleAction = RuleEmailAction | RuleWebhookAction

@export()
type RuleEmailAction = {
  @description('specifies the type of the action. There are two types of actions: RuleEmailAction and RuleWebhookAction.')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.RuleEmailAction'

  @description('the list of administrator\'s custom email addresses to notify of the activation of the alert.')
  customEmails: string[]?

  @description('Whether the administrators (service and co-administrators) of the service should be notified when the alert is activated.')
  sendToServiceOwners: bool?
}

type RuleWebhookAction = {
  @description('specifies the type of the action. There are two types of actions: RuleEmailAction and RuleWebhookAction.')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.RuleWebhookAction'

  @description('the dictionary of custom properties to include with the post operation. These data are appended to the webhook payload.')
  properties: { *: string }?

  @description('the service uri to Post the notification when the alert activates or resolves.')
  serviceUri: string?
}

@export()
type RuleCondition = {
  @description('the resource from which the rule collects its data. For this type dataSource will always be of type RuleMetricDataSource.')
  dataSource: RuleDataSource?

  @description('Set the object type.')
  'odata.type':
    | 'Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition'
    | 'Microsoft.Azure.Management.Insights.Models.ManagementEventRuleCondition'
    | 'Microsoft.Azure.Management.Insights.Models.ThresholdRuleCondition'
}

@export()
type RuleDataSource = {
  @description('the namespace of the metric.')
  metricNamespace: string?

  @description('the location of the resource.')
  resourceLocation: string?

  @description('the resource identifier of the resource the rule monitors. NOTE: this property cannot be updated for an existing rule.')
  resourceUri: string?

  @description('Set the object type.')
  'odata.type':
    | 'Microsoft.Azure.Management.Insights.Models.RuleManagementEventDataSource'
    | 'Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource'
}

@export()
type RuleManagementEventDataSource = {
  @description('specifies the type of data source. There are two types of rule data sources: RuleMetricDataSource and RuleManagementEventDataSource.')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.RuleManagementEventDataSource'

  @description('the claims.')
  claims: {
    @description('the email address.')
    emailAddress: string?
  }?

  @description('the event name.')
  eventName: string?

  @description('the event source.')
  eventSource: string?

  @description('the level.')
  level: string?

  @description('The name of the operation that should be checked for. If no name is provided, any operation will match.')
  operationName: string?

  @description('the resource group name.')
  resourceGroupName: string?

  @description('the resource provider name.')
  resourceProviderName: string?

  @description('The status of the operation that should be checked for. If no status is provided, any status will match.')
  status: string?

  @description('the substatus.')
  subStatus: string?
}

@export()
type RuleMetricDataSource = {
  @description('specifies the type of data source. There are two types of rule data sources: RuleMetricDataSource and RuleManagementEventDataSource.')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.RuleMetricDataSource'

  @description('the name of the metric that defines what the rule monitors.')
  metricName: string?
}

@export()
type LocationThresholdRuleCondition = {
  @description('specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.LocationThresholdRuleCondition'

  @description('the number of locations that must fail to activate the alert.')
  @minValue(0)
  failedLocationCount: int

  @description('the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.')
  windowSize: string
}

@export()
type ManagementEventRuleCondition = {
  @description('specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.ManagementEventRuleCondition'

  @description('How the data that is collected should be combined over time and when the alert is activated. Note that for management event alerts aggregation is optional – if it is not provided then any event will cause the alert to activate.')
  aggregation: ManagementEventAggregationCondition?
}

@export()
type ManagementEventAggregationCondition = {
  @description('the condition operator.')
  operator: ('GreaterThan' | 'GreaterThanOrEqual' | 'LessThan' | 'LessThanOrEqual')?

  @description('The threshold value that activates the alert.')
  threshold: int?

  @description('the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.')
  windowSize: string?
}

@export()
type ThresholdRuleCondition = {
  @description('specifies the type of condition. This can be one of three types: ManagementEventRuleCondition (occurrences of management events), LocationThresholdRuleCondition (based on the number of failures of a web test), and ThresholdRuleCondition (based on the threshold of a metric).')
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.ThresholdRuleCondition'

  @description('the operator used to compare the data and the threshold.')
  operator: 'GreaterThan' | 'GreaterThanOrEqual' | 'LessThan' | 'LessThanOrEqual'

  @description('the threshold value that activates the alert.')
  threshold: int

  @description('the time aggregation operator. How the data that are collected should be combined over time. The default value is the PrimaryAggregationType of the Metric.')
  timeAggregation: ('Average' | 'Last' | 'Maximum' | 'Minimum' | 'Total')?

  @description('the period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold. If specified then it must be between 5 minutes and 1 day.')
  windowSize: string?
}
