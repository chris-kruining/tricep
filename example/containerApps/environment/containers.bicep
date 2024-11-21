import { Context } from '../../../src/types.bicep'
import { with_name } from '../../../src/common/context.bicep'
import { with_managed_identity } from '../../../src/common/identity.bicep'
import { container_registry } from '../../../src/recommended/container-registry.bicep'
import {
  container_app
  container
  with_dapr
  container_app_environment
  with_auto_scaling
  with_environment
  with_app_logs
} from '../../../src/recommended/container-app.bicep'

targetScope = 'resourceGroup'

param context Context
param customerId string
param sharedKey string

var containerRegistryConfig = container_registry(with_name(context, context.project), [])
var containerAppEnvironmentConfig = container_app_environment(with_name(context, context.project), [
  with_app_logs(customerId, sharedKey)
])
var containerApp1Config = container_app(
  with_name(context, 'app_1'),
  [
    container('container 1', 'some-container-image')
    container('container 2', 'some-other-container-image')
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
  with_name(context, 'app_2'),
  [
    container('container 1', 'some-third-container-image')
  ],
  [
    with_managed_identity()
    with_environment(environment.id)
    with_dapr(context, 3001)
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
  properties: containerAppEnvironmentConfig.properties
}

resource app_1 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerApp1Config.name
  location: containerApp1Config.location
  identity: containerApp1Config.identity
  properties: containerApp1Config.properties

  // properties: {
  //   configuration: {
  //     ingress: {
  //       external: true
  //       targetPort: 80
  //       allowInsecure: false
  //       traffic: [
  //         {
  //           latestRevision: true
  //           weight: 100
  //         }
  //       ]
  //     }
  //     registries: [
  //       {
  //         identity: uai.id
  //         server: acr.outputs.loginServer
  //       }
  //     ]
  //   }
  // }
}

resource app_2 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerApp2Config.name
  location: containerApp2Config.location
  identity: containerApp2Config.identity
  properties: containerApp2Config.properties
}

output app_1 resource'Microsoft.App/containerApps@2022-06-01-preview' = app_1
output app_2 resource'Microsoft.App/containerApps@2022-06-01-preview' = app_2
