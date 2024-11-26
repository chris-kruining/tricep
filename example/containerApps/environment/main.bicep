import { Context } from '../../../src/types.bicep'
import { create_context } from '../../../src/common/context.bicep'
import { resource_group } from '../../../src/recommended/resources/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string
param environment string

var context = create_context({
  project: 'projectName'
  nameConventionTemplate: '$type-$environment-$location-$project'
  environment: environment
  location: 'westeurope'
  deployedAt: deployedAt
  tenant: tenant()
  tags: {}
})

var resourceGroupConfig = resource_group(context, [])

resource group 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: resourceGroupConfig.name
  location: resourceGroupConfig.location
  tags: resourceGroupConfig.tags
  properties: resourceGroupConfig.properties
}

// module alertLogicApp 'alert-logic-app.bicep' = {
//   name: 'alertLogicApp'
//   scope: group
//   params: {
//     context: context
//   }
// }

module monitoring 'monitoring.bicep' = {
  name: 'monitoring'
  scope: group
  params: {
    context: context
    // workFlowId: alertLogicApp.outputs.id
    // workFlowUrl: alertLogicApp.outputs.url
    workFlowId: '/subscriptions/bf9c57f6-6016-4212-b3f7-a3e8ff8b1670/resourceGroups/menicon-lensservices/providers/Microsoft.Web/sites/alert-messages/workflows/test'
    workFlowUrl: 'https://alert-messages.azurewebsites.net:443/api/test/triggers/When_a_HTTP_request_is_received/invoke?api-version=2022-05-01&sp=%2Ftriggers%2FWhen_a_HTTP_request_is_received%2Frun&sv=1.0&sig=BO_3rGjW0W97whBKFvFswOKT453fpeTENr8DkDCw5KE'
  }
}

module containers 'containers.bicep' = {
  name: 'containers'
  scope: group
  params: {
    context: context
    logAnalyticsId: monitoring.outputs.logAnalyticsId
  }
}
