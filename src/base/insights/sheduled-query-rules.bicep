import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func sheduled_query_rules(context Context, properties Properties, options Options) object =>
  create_resource(
    context,
    'sheduledQueryRules',
    union(
      [
        {
          kind: properties.kind
          properties: {}
        }
      ],
      options
    )
  )

@export()
@discriminator('kind')
type Properties = LogAlertProperties | LogToMetricProperties

@export()
type LogAlertProperties = {
  kind: 'LogAlert'

  @description('Actions to invoke when the alert fires.')
  actions: Actions?

  @description('The flag that indicates whether the alert should be automatically resolved or not. The default is true.')
  autoMitigate: bool?

  @description('The flag which indicates whether this scheduled query rule should be stored in the customer\'s storage. The default is false.')
  checkWorkspaceAlertsStorageConfigured: bool?

  @description('The rule criteria that defines the conditions of the scheduled query rule.')
  criteria: ScheduledQueryRuleCriteria?

  @description('The description of the scheduled query rule.')
  description: string?

  @description('The display name of the alert rule.')
  displayName: string?

  @description('The flag which indicates whether this scheduled query rule is enabled. Value should be true or false.')
  enabled: bool?

  @description('How often the scheduled query rule is evaluated represented in ISO 8601 duration format.')
  evaluationFrequency: string

  @description('Mute actions for the chosen period of time (in ISO 8601 duration format) after the alert is fired.')
  muteActionsDuration: string?

  @description('If specified then overrides the query time range (default is WindowSize*NumberOfEvaluationPeriods).')
  overrideQueryTimeRange: string?

  @description('Defines the configuration for resolving fired alerts.')
  ruleResolveConfiguration: RuleResolveConfiguration?

  @description('The list of resource id\'s that this scheduled query rule is scoped to.')
  scopes: string[]?

  @description('Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest.')
  severity: 0 | 1 | 2 | 3 | 4

  @description('The flag which indicates whether the provided query should be validated or not. The default is false.')
  skipQueryValidation: bool?

  @description('List of resource type of the target resource(s) on which the alert is created/updated. For example if the scope is a resource group and targetResourceTypes is Microsoft.Compute/virtualMachines, then a different alert will be fired for each virtual machine in the resource group which meet the alert criteria.')
  targetResourceTypes: string[]?

  @description('The period of time (in ISO 8601 duration format) on which the Alert query will be executed (bin size).')
  windowSize: string
}

@export()
type LogToMetricProperties = {
  kind: 'LogToMetric'

  @description('Actions to invoke when the alert fires.')
  actions: Actions?

  @description('The rule criteria that defines the conditions of the scheduled query rule.')
  criteria: ScheduledQueryRuleCriteria?

  @description('The description of the scheduled query rule.')
  description: string?

  @description('The display name of the alert rule.')
  displayName: string?

  @description('The flag which indicates whether this scheduled query rule is enabled. Value should be true or false.')
  enabled: bool?

  @description('The list of resource id\'s that this scheduled query rule is scoped to.')
  scopes: string[]?
}

@export()
type Kind = 'LogAlert' | 'LogToMetric'

@export()
type ScheduledQueryRuleProperties = {
  // @description('Actions to invoke when the alert fires.')
  // actions: Actions?

  // @description('The flag that indicates whether the alert should be automatically resolved or not. The default is true. Relevant only for rules of the kind LogAlert.')
  // autoMitigate: bool?

  // @description('The flag which indicates whether this scheduled query rule should be stored in the customer\'s storage. The default is false. Relevant only for rules of the kind LogAlert.')
  // checkWorkspaceAlertsStorageConfigured: bool?

  // @description('The rule criteria that defines the conditions of the scheduled query rule.')
  // criteria: ScheduledQueryRuleCriteria?

  // @description('The description of the scheduled query rule.')
  // description: string?

  // @description('The display name of the alert rule.')
  // displayName: string?

  // @description('The flag which indicates whether this scheduled query rule is enabled. Value should be true or false.')
  // enabled: bool?

  // @description('How often the scheduled query rule is evaluated represented in ISO 8601 duration format. Relevant and required only for rules of the kind LogAlert.')
  // evaluationFrequency: string?

  // @description('Mute actions for the chosen period of time (in ISO 8601 duration format) after the alert is fired. Relevant only for rules of the kind LogAlert.')
  // muteActionsDuration: string?

  // @description('If specified then overrides the query time range (default is WindowSize*NumberOfEvaluationPeriods). Relevant only for rules of the kind LogAlert.')
  // overrideQueryTimeRange: string?

  // @description('Defines the configuration for resolving fired alerts. Relevant only for rules of the kind LogAlert.')
  // ruleResolveConfiguration: RuleResolveConfiguration?

  // @description('The list of resource id\'s that this scheduled query rule is scoped to.')
  // scopes: string[]?

  // @description('Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.')
  // severity: 0 | 1 | 2 | 3 | 4?

  // @description('The flag which indicates whether the provided query should be validated or not. The default is false. Relevant only for rules of the kind LogAlert.')
  // skipQueryValidation: bool?

  // @description('List of resource type of the target resource(s) on which the alert is created/updated. For example if the scope is a resource group and targetResourceTypes is Microsoft.Compute/virtualMachines, then a different alert will be fired for each virtual machine in the resource group which meet the alert criteria. Relevant only for rules of the kind LogAlert.')
  // targetResourceTypes: string[]?

  // @description('The period of time (in ISO 8601 duration format) on which the Alert query will be executed (bin size). Relevant and required only for rules of the kind LogAlert.')
  // windowSize: string?
}

@export()
type Actions = {
  @description('Action Group resource Ids to invoke when the alert fires.')
  actionGroups: string[]?

  @description('The properties of an action properties.')
  actionProperties: { *: string }?

  @description('The properties of an alert payload.')
  customProperties: { *: string }?
}

@export()
type ScheduledQueryRuleCriteria = {
  @description('A list of conditions to evaluate against the specified scopes.')
  allOf: Condition[]?
}

@export()
type Condition = {
  @description('List of Dimensions conditions.')
  dimensions: Dimension[]?

  @description('The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.')
  failingPeriods: ConditionFailingPeriods?

  @description('The column containing the metric measure number. Relevant only for rules of the kind LogAlert.')
  metricMeasureColumn: string?

  @description('The name of the metric to be sent. Relevant and required only for rules of the kind LogToMetric.')
  metricName: string?

  @description('The criteria operator. Relevant and required only for rules of the kind LogAlert.')
  operator: ('Equals' | 'GreaterThan' | 'GreaterThanOrEqual' | 'LessThan' | 'LessThanOrEqual')?

  @description('Log query alert.')
  query: string?

  @description('The column containing the resource id. The content of the column must be a uri formatted as resource id. Relevant only for rules of the kind LogAlert.')
  resourceIdColumn: string?

  @description('the criteria threshold value that activates the alert. Relevant and required only for rules of the kind LogAlert.')
  threshold: int?

  @description('Aggregation type. Relevant and required only for rules of the kind LogAlert.')
  timeAggregation: ('Average' | 'Count' | 'Maximum' | 'Minimum' | 'Total')?
}

@export()
type Dimension = {
  @description('Name of the dimension.')
  name: string

  @description('Operator for dimension values.')
  operator: 'Exclude' | 'Include'

  @description('List of dimension values.')
  values: string[]
}

@export()
type ConditionFailingPeriods = {
  @description('The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods. Default value is 1.')
  minFailingPeriodsToAlert: int?

  @description('The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points. Default value is 1.')
  numberOfEvaluationPeriods: int?
}

@export()
type RuleResolveConfiguration = {
  @description('The flag that indicates whether or not to auto resolve a fired alert.')
  autoResolved: bool?

  @description('The duration a rule must evaluate as healthy before the fired alert is automatically resolved represented in ISO 8601 duration format.')
  timeToResolve: string?
}
