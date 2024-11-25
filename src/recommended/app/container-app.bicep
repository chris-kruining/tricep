import * as base from '../../base/app/container-app.bicep'
import { Context, Options } from '../../types.bicep'
import { create_name, to_location_abbreviation, to_resource_abbreviation } from '../../internal/name.bicep'
import { container_app_environment as base_container_app_environment } from '../../base/app/container-app/environment.bicep'

@export()
func container_app(context Context, containers base.Container[], options Options) base.ContainerApp =>
  base.container_app(context, containers, options)

@export()
func container(name string, image string) base.Container => {
  name: name
  image: image
  resources: {
    cpu: '0.5'
    memory: '0.5Gi'
  }
}

@export()
func with_environment(id string) object => {
  properties: {
    environmentId: id
  }
}

@export()
func with_dapr(context Context, port int) object => {
  properties: {
    configuration: {
      dapr: {
        appId: create_name(
          {
            env: context.environment
            loc: to_location_abbreviation(context.location)
            type: to_resource_abbreviation('containerApp')
            name: context.name
          },
          context.nameConventionTemplate
        )
        appPort: port
        enabled: true
        enabledApiLogging: true
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
          name: rule.key
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
