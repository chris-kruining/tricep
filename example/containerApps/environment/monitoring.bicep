import { Context } from '../../../src/types.bicep'
import { log_analytics } from '../../../src/recommended/operational-insights/log-analytics.bicep'

targetScope = 'resourceGroup'

param context Context

var logAnalyticsConfig = log_analytics(context, [])

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsConfig.name
  location: logAnalyticsConfig.location
  properties: logAnalyticsConfig.properties
}

// output logAnalytics resource'Microsoft.OperationalInsights/workspaces@2021-06-01' = logAnalytics
output la_customerId string = logAnalytics.properties.customerId
output la_sharedKey string = logAnalytics.listKeys().primarySharedKey
