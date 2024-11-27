import * as base from '../../base/app/container-app.bicep'
import { Context, Options, uint16 } from '../../types.bicep'
import { create_name, to_location_abbreviation, to_resource_abbreviation } from '../../internal/name.bicep'
import { container_app_environment as base_container_app_environment } from '../../base/app/container-app/environment.bicep'

@export()
func container_app(context Context, containers base.Container[], options Options) object =>
  base.container_app(
    context,
    containers,
    union(
      [
        {
          properties: {
            configuration: {
              activeRevisionsMode: 'Single'
            }
          }
        }
      ],
      options
    )
  )

@export()
func container(config ContainerConfig) base.Container => {
  name: replace(config.name, ' ', '-')
  image: config.image
  resources: config.?resources ?? {
    cpu: '0.25'
    memory: '0.5Gi'
  }
}

type ContainerConfig = {
  name: string
  image: string
  resources: base.Container.resources?
}

@export()
var resources_xxs = { cpu: '0.25', memory: '0.5Gi' }
@export()
var resources_xs = { cpu: '0.5', memory: '1.0Gi' }
@export()
var resources_s = { cpu: '0.75', memory: '1.5Gi' }
@export()
var resources_m = { cpu: '1.0', memory: '2.0Gi' }
@export()
var resources_l = { cpu: '1.25', memory: '2.5Gi' }
@export()
var resources_xl = { cpu: '1.5', memory: '3.0Gi' }
@export()
var resources_xxl = { cpu: '1.75', memory: '3.5Gi' }
@export()
var resources_xxxl = { cpu: '2.0', memory: '4.0Gi' }

@export()
func with_public_access(config PublicAccessConfig) object => {
  properties: {
    configuration: {
      ingress: {
        external: true
        targetPort: config.port
        transport: config.transport ?? 'auto'
        allowInsecure: false
        traffic: [
          {
            weight: 100
            latestRevision: true
          }
        ]
        corsPolicy: config.cors
      }
    }
  }
}

type PublicAccessConfig = {
  port: uint16
  cors: base.CorsPolicy
  transport: base.Ingress.transport?
}

@export()
func with_traffic_splitting(config TrafficSplittingConfig) object => {
  properties: {
    configuration: {
      activeRevisionsMode: 'Multiple'
      ingress: {
        traffic: map(items(config.weights), x => {
          '${config.by == 'name' ? 'revisionName' : 'label'}': x.key
          weight: x.value
        })
      }
    }
  }
}

@export()
func with_insecure_ingress() object => {
  properties: {
    configuration: {
      ingress: {
        allowInsecure: true
      }
    }
  }
}

type TrafficSplittingConfig = {
  by: 'name' | 'label'
  weights: {
    @minValue(0)
    @maxValue(100)
    *: int
  }
}

@export()
func with_environment(id string) object => {
  properties: {
    environmentId: id
  }
}

@export()
func with_dapr(context Context, port int) { properties: { configuration: { dapr: base.Dapr } } } => {
  properties: {
    configuration: {
      dapr: {
        appId: create_name(
          {
            env: context.environment
            loc: to_location_abbreviation(context.location)
            type: to_resource_abbreviation('containerApp')
            project: context.project
          },
          context.nameConventionTemplate
        )
        appPort: port
        appProtocol: 'http'
        enabled: true
        enableApiLogging: true
        logLevel: 'info'
      }
    }
  }
}

@export()
func with_auto_scaling(min int, max int, rules { *: object }) object => {
  properties: {
    template: {
      scale: {
        minReplicas: min
        maxReplicas: max
        rules: map(items(rules), (rule) => {
          name: toLower(rule.key)
          http: {
            metadata: rule.value
          }
        })
      }
    }
  }
}

@export()
func container_app_environment(context Context, options Options) object =>
  base_container_app_environment(context, options)

@export()
@description('''
Currently this is unusable due to a bug in ARM

https://github.com/Azure/bicep-types-az/issues/1407
''')
func with_app_logs(customerId string, sharedKey string) object => {
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: customerId
        sharedKey: sharedKey
      }
    }
  }
}
