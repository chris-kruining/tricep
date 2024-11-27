import { Context } from '../../../src/types.bicep'
import { __dynamic } from '../../../src/utilities.bicep'
import { log_analytics } from '../../../src/recommended/operational-insights/log-analytics.bicep'
import { app_insights } from '../../../src/recommended/insights/app-insights.bicep'
import { action_group, with_receiver } from '../../../src/recommended/insights/action-group.bicep'
import { sheduled_query_rules, create_log_alert, without_auto_mitigate, with_criteria, with_action_group } from '../../../src/recommended/insights/sheduled-query-rules.bicep'

targetScope = 'resourceGroup'

param context Context
param alertLogicApp resource'Microsoft.Logic/workflows@2019-05-01'

var logAnalyticsConfig = log_analytics(context, [])
var appInsightsConfig = app_insights(context, logAnalytics.id, [])
var actionGroupConfig = action_group(context, 'Alerts', [])
var sheduledQueryRulesConfig = sheduled_query_rules(
  context,
  create_log_alert({
    displayName: 'Failures occured'
    evaluationFrequency: 'PT5M'
    severity: 1
    windowSize: 'PT10M'
    scopes: [
      appInsights.id
    ]
    targetResourceTypes: [
      'microsoft.insights/components'
    ]
  }),
  [
    without_auto_mitigate()
    with_criteria([
      {
        query: 'requests\n| where success == false\n| summarize failedCount=sum(itemCount), impactedUsers=dcount(user_Id) by operation_Name\n| order by failedCount desc\n'
        timeAggregation: 'Count'
        dimensions: []
        operator: 'GreaterThan'
        threshold: 0
        failingPeriods: {
          numberOfEvaluationPeriods: 1
          minFailingPeriodsToAlert: 1
        }
      }
    ])
    with_action_group(actionGroup.id)
  ]
)

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsConfig.name
  location: logAnalyticsConfig.location
  tags: logAnalyticsConfig.tags
  properties: logAnalyticsConfig.properties
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsConfig.name
  location: appInsightsConfig.location
  tags: appInsightsConfig.tags
  kind: appInsightsConfig.kind
  properties: appInsightsConfig.properties
}

resource actionGroup 'microsoft.insights/actionGroups@2023-09-01-preview' = {
  name: actionGroupConfig.name
  location: actionGroupConfig.location
  tags: actionGroupConfig.tags
  properties: __dynamic(actionGroupConfig, [
    with_receiver('logicApp', {
      name: 'Alert messages logic app'
      resourceId: alertLogicApp.id
      callbackUrl: alertLogicApp.listCallbackUrl().value
      useCommonAlertSchema: true
    })
  ])
}

resource scheduledQueryRules 'Microsoft.Insights/scheduledQueryRules@2024-01-01-preview' = {
  name: sheduledQueryRulesConfig.name
  location: sheduledQueryRulesConfig.location
  tags: sheduledQueryRulesConfig.tags
  properties: sheduledQueryRulesConfig.properties
}

output logAnalyticsId string = logAnalytics.id
