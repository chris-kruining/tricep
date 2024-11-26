import { Context } from '../../../src/types.bicep'
import { log_analytics } from '../../../src/recommended/operational-insights/log-analytics.bicep'
import { app_insights } from '../../../src/recommended/insights/app-insights.bicep'
import { action_group, with_receiver } from '../../../src/recommended/insights/action-group.bicep'
import { sheduled_query_rules, create_log_alert, without_auto_mitigate, with_criteria, with_action_group } from '../../../src/recommended/insights/sheduled-query-rules.bicep'

targetScope = 'resourceGroup'

param context Context
param workFlowId string
param workFlowUrl string

var logAnalyticsConfig = log_analytics(context, [])
var appInsightsConfig = app_insights(context, logAnalytics.id, [])
var actionGroupConfig = action_group(context, 'Alerts', [
  with_receiver('logicApp', {
    name: 'Alert messages logic app'
    resourceId: workFlowId
    callbackUrl: workFlowUrl
    useCommonAlertSchema: true
  })
])
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
  properties: logAnalyticsConfig.properties
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsConfig.name
  location: appInsightsConfig.location
  kind: appInsightsConfig.kind
  properties: appInsightsConfig.properties
}

resource actionGroup 'microsoft.insights/actionGroups@2023-09-01-preview' = {
  name: actionGroupConfig.name
  location: actionGroupConfig.location
  properties: actionGroupConfig.properties
}

resource scheduledQueryRules 'Microsoft.Insights/scheduledQueryRules@2024-01-01-preview' = {
  name: sheduledQueryRulesConfig.name
  location: sheduledQueryRulesConfig.location
  properties: sheduledQueryRulesConfig.properties
}

// output logAnalytics resource'Microsoft.OperationalInsights/workspaces@2021-06-01' = logAnalytics
output logAnalyticsId string = logAnalytics.id
// output logAnalyticsName string = logAnalytics.name
// output la_customerId string = logAnalytics.properties.customerId
// output la_sharedKey string = logAnalytics.listKeys().primarySharedKey
