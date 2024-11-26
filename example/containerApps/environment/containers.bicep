import { Context } from '../../../src/types.bicep'
import { with_name } from '../../../src/common/context.bicep'
import { with_managed_identity } from '../../../src/common/identity.bicep'
import { container_registry } from '../../../src/recommended/container-registry/container-registry.bicep'
import {
  container_app
  container
  with_dapr
  container_app_environment
  with_auto_scaling
  with_environment
  with_app_logs
  with_traffic_splitting
  resources_l
} from '../../../src/recommended/app/container-app.bicep'

targetScope = 'resourceGroup'

param context Context
param logAnalyticsId string
// param logAnalyticsName string

// resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
//   name: logAnalyticsName
// }

var containerRegistryConfig = container_registry(with_name(context, context.project), [])
var containerAppEnvironmentConfig = container_app_environment(with_name(context, context.project), [
  // with_app_logs(logAnalytics.properties.customerId, logAnalytics.listKeys().primarySharedKey)
])
var containerApp1Config = container_app(
  with_name(context, 'app-1'),
  [
    container({ name: 'container 1', image: 'some-container-image' })
    container({ name: 'container 2', image: 'some-other-container-image', resources: resources_l })
  ],
  [
    with_managed_identity()
    with_environment(environment.id)
    with_dapr(context, 3000)
    with_auto_scaling(0, 1, {
      ruleName: {
        concurrentRequests: '10'
      }
    })
  ]
)
var containerApp2Config = container_app(
  with_name(context, 'app-2'),
  [
    container({ name: 'container-1', image: 'some-third-container-image' })
  ],
  [
    with_managed_identity()
    with_environment(environment.id)
    with_dapr(context, 3000)
    with_traffic_splitting({
      by: 'name'
      weights: {
        rev1: 80
        rev2: 20
      }
    })
    with_auto_scaling(1, 1, {
      ruleName: {
        concurrentRequests: '10'
      }
    })
  ]
)

resource registry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryConfig.name
  location: containerRegistryConfig.location
  tags: containerRegistryConfig.tags
  sku: containerRegistryConfig.sku
  properties: containerRegistryConfig.properties
}

resource environment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: containerAppEnvironmentConfig.name
  location: containerAppEnvironmentConfig.location
  tags: containerAppEnvironmentConfig.tags
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: reference(logAnalyticsId, '2023-09-01').customerId
        sharedKey: listKeys(logAnalyticsId, '2023-09-01').primarySharedKey
      }
    }
    peerAuthentication: {
      mtls: {
        enabled: false
      }
    }
    peerTrafficConfiguration: {
      encryption: {
        enabled: false
      }
    }
  }
}

resource app_1 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerApp1Config.name
  location: containerApp1Config.location
  identity: containerApp1Config.identity
  properties: containerApp1Config.properties
}

resource app_2 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerApp2Config.name
  location: containerApp2Config.location
  identity: containerApp2Config.identity
  properties: containerApp2Config.properties
}

// output app_1 resource'Microsoft.App/containerApps@2022-06-01-preview' = app_1
// output app_2 resource'Microsoft.App/containerApps@2022-06-01-preview' = app_2
