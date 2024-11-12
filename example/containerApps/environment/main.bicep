import { createContext } from '../../../src/context.bicep'
import { resourceGroup } from '../../../src/recommended/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string
param environment string

var context = createContext('appName', '$type-$env-$loc-$name', environment, 'westeurope', {
  deployedAt: deployedAt
})

var resourceGroupConfig = resourceGroup(context, [])

resource group 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: resourceGroupConfig.name
  location: resourceGroupConfig.location
  tags: resourceGroupConfig.tags
  properties: resourceGroupConfig.properties
}

module containers 'containers.bicep' = {
  scope: group
  name: 'containers'
  params: {
    context: context
  }
}
