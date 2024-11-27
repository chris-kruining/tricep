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

module alertLogicApp 'alert-logic-app.bicep' = {
  name: 'alertLogicApp'
  scope: group
  params: {
    context: context
  }
}

module monitoring 'monitoring.bicep' = {
  name: 'monitoring'
  scope: group
  params: {
    context: context
    alertLogicApp: alertLogicApp.outputs.logicApp
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
