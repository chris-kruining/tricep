import * as base from '../../base/insights/sheduled-query-rules.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func sheduled_query_rules(context Context, properties base.Properties, options Options) object =>
  base.sheduled_query_rules(context, properties, options)

@export()
func create_log_alert(properties LogAlertProperties) base.LogAlertProperties => {
  kind: 'LogAlert'
  enabled: true
  checkWorkspaceAlertsStorageConfigured: properties.?checkWorkspaceAlertsStorageConfigured ?? null
  description: properties.?description ?? null
  displayName: properties.?displayName ?? null
  evaluationFrequency: properties.evaluationFrequency
  muteActionsDuration: properties.?muteActionsDuration ?? null
  overrideQueryTimeRange: properties.?overrideQueryTimeRange ?? null
  ruleResolveConfiguration: properties.?ruleResolveConfiguration ?? null
  scopes: properties.?scopes ?? null
  severity: properties.severity
  skipQueryValidation: properties.?skipQueryValidation ?? null
  targetResourceTypes: properties.?targetResourceTypes ?? null
  windowSize: properties.windowSize
}

type LogAlertProperties = {
  checkWorkspaceAlertsStorageConfigured: base.LogAlertProperties.checkWorkspaceAlertsStorageConfigured
  description: base.LogAlertProperties.description
  displayName: base.LogAlertProperties.displayName
  evaluationFrequency: base.LogAlertProperties.evaluationFrequency
  muteActionsDuration: base.LogAlertProperties.muteActionsDuration
  overrideQueryTimeRange: base.LogAlertProperties.overrideQueryTimeRange
  ruleResolveConfiguration: base.LogAlertProperties.ruleResolveConfiguration
  scopes: base.LogAlertProperties.scopes
  severity: base.LogAlertProperties.severity
  skipQueryValidation: base.LogAlertProperties.skipQueryValidation
  targetResourceTypes: base.LogAlertProperties.targetResourceTypes
  windowSize: base.LogAlertProperties.windowSize
}

@export()
func create_log_to_metric() base.LogToMetricProperties => {
  kind: 'LogToMetric'
}

@export()
func without_auto_mitigate() object => {
  properties: {
    autoMigitage: false
  }
}

@export()
func with_criteria(criteria base.Condition[]) object => {
  properties: {
    criteria: {
      allOf: criteria
    }
  }
}

@export()
func with_action_group(actionGroupId string) object => {
  properties: {
    actions: {
      actionGroups: [
        actionGroupId
      ]
    }
  }
}
