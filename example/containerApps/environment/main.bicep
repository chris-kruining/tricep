import { Context } from '../../../src/types.bicep'
import { createContext } from '../../../src/common/context.bicep'
import { resourceGroup } from '../../../src/recommended/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string
param environment string

var context = createContext({
  name: 'appName'
  nameConventionTemplate: '$type-$env-$loc-$name'
  environment: environment
  location: 'westeurope'
  deployedAt: deployedAt
  tenant: tenant()
  tags: {}
})

var resourceGroupConfig = resourceGroup(context, [])

resource group 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: resourceGroupConfig.name
  location: resourceGroupConfig.location
  tags: resourceGroupConfig.tags
  properties: resourceGroupConfig.properties
}

module containers 'containers.bicep' = {
  name: 'containers'
  scope: group
  params: {
    context: context
  }
}
