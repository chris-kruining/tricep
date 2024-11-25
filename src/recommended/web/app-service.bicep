import * as base from '../../base/web/app-service.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func app_service(context Context, appServicePlan string, vnetName string, appInsights string, options Options) object =>
  base.app_service(
    context,
    union(
      [
        base.with_site_config(appServicePlan, vnetName, true, true, '1.2', 'Deny', false)
        base.with_app_settings([
          {
            name: 'ASPNETCORE_ENVIRONMENT'
            value: context.environment
          }
          {
            name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
            value: appInsights
          }
          {
            name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
            value: '~2'
          }
        ])
        base.with_ip_restrictions([
          {
            name: 'Allow backend subnet ${context.environment}'
            vnetSubnetResourceId: vnetName
            priority: 110
            action: 'Allow'
          }
        ])
      ],
      options
    )
  )

@export()
func with_always_on(alwaysOn bool) object => base.with_always_on(alwaysOn)

@export()
func with_app_settings(appSettings base.AppSetting[]) object => base.with_app_settings(appSettings)

@export()
func with_connection_strings(connectionStrings base.ConnStringInfo[]) object =>
  base.with_connection_strings(connectionStrings)
