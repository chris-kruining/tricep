import { Context } from 'types.bicep'

targetScope = 'resourceGroup'

param context Context

resource registry 'Microsoft.ContainerRegistry/registries@2025-11-01' = {
  name: 'acr${context.locationAbbreviation}${context.environment}${context.projectName}'
  location: context.location
  sku: {
    name: 'Standard'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    adminUserEnabled: true
    anonymousPullEnabled: true
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
    publicNetworkAccess: 'Enabled'
  }
}
