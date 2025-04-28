import { Context } from '../../../src/types.bicep'
import { __dynamic } from '../../../src/utilities.bicep'
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

var containerRegistryConfig = container_registry(context, [])
var containerAppEnvironmentConfig = container_app_environment(context, [])
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

resource registry 'Microsoft.ContainerRegistry/registries@2025-04-01' = {
  name: containerRegistryConfig.name
  location: containerRegistryConfig.location
  tags: containerRegistryConfig.tags
  sku: containerRegistryConfig.sku
  properties: containerRegistryConfig.properties
}

resource environment 'Microsoft.App/managedEnvironments@2025-01-01' = {
  name: containerAppEnvironmentConfig.name
  location: containerAppEnvironmentConfig.location
  tags: containerAppEnvironmentConfig.tags
  properties: __dynamic(containerAppEnvironmentConfig, [
    // with_app_logs(reference(logAnalyticsId, '2023-09-01').customerId, 'logAnalytics.listKeys().primarySharedKey')
  ])
}

resource app_1 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerApp1Config.name
  location: containerApp1Config.location
  tags: containerApp1Config.tags
  identity: containerApp1Config.identity
  properties: containerApp1Config.properties
}

resource app_2 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerApp2Config.name
  location: containerApp2Config.location
  tags: containerApp2Config.tags
  identity: containerApp2Config.identity
  properties: containerApp2Config.properties
}
