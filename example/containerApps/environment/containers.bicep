import { Context } from '../../../src/types.bicep'
import { withManagedIdentity } from '../../../src/common/identity.bicep'
import { containerRegistry } from '../../../src/recommended/container-registry.bicep'
import { containerApp, containerAppEnvironment } from '../../../src/recommended/container-app.bicep'

targetScope = 'resourceGroup'

param context Context

var containerRegistryConfig = containerRegistry(context, [])
var containerAppEnvironmentConfig = containerAppEnvironment(context, [])
var containerAppConfig = containerApp(context, [
  withManagedIdentity()
])

resource registry 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: containerRegistryConfig.name
  location: containerRegistryConfig.location
  tags: containerRegistryConfig.tags
  sku: containerRegistryConfig.sku
  properties: containerRegistryConfig.properties
}

resource environment 'Microsoft.App/managedEnvironments@2022-06-01-preview' = {
  name: containerAppEnvironmentConfig.name
  location: containerAppEnvironmentConfig.location
  sku: containerAppEnvironmentConfig.sku
  properties: containerAppEnvironmentConfig.properties

  // properties: {
  //   appLogsConfiguration: {
  //     destination: 'log-analytics'
  //     logAnalyticsConfiguration: {
  //       customerId: logAnalytics.properties.customerId
  //       sharedKey: logAnalytics.listKeys().primarySharedKey
  //     }
  //   }
  // }
}

resource app 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppConfig.name
  location: containerAppConfig.location
  identity: containerAppConfig.identity
  properties: containerAppConfig.properties

  // properties: {
  //   managedEnvironmentId: containerAppEnv.id
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
  //   template: {
  //     revisionSuffix: 'firstrevision'
  //     containers: [
  //       {
  //         name: containerAppName
  //         image: acrImportImage.outputs.importedImages[0].acrHostedImage
  //         resources: {
  //           cpu: json('.25')
  //           memory: '.5Gi'
  //         }
  //       }
  //     ]
  //     scale: {
  //       minReplicas: minReplica
  //       maxReplicas: maxReplica
  //       rules: [
  //         {
  //           name: 'http-requests'
  //           http: {
  //             metadata: {
  //               concurrentRequests: '10'
  //             }
  //           }
  //         }
  //       ]
  //     }
  //   }
  // }
}

// output app resource'Microsoft.App/containerApps@2022-06-01-preview' = app
