import * as base from '../base/app-service.bicep'
import { Context, Options } from '../types.bicep'

@export()
func appService(context Context, appServicePlan string, vnetName string, appInsights string, options Options) object =>
  base.appService(
    context,
    union(
      [
        base.withSiteConfig(appServicePlan, vnetName, true, true, '1.2', 'Deny', false)
        base.withAppSettings([
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
        base.withIpRestrictions([
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
func withAlwaysOn(alwaysOn bool) object => base.withAlwaysOn(alwaysOn)

@export()
func withAppSettings(appSettings base.AppSetting[]) object => base.withAppSettings(appSettings)

@export()
func withConnectionStrings(connectionStrings base.ConnStringInfo[]) object =>
  base.withConnectionStrings(connectionStrings)

@export()
func withAllowManagementVm(managementSubNet string) object =>
  base.withIpRestrictions([
    {
      name: 'Allow management vm'
      vnetSubnetResourceId: managementSubNet
      priority: 100
      action: 'Allow'
    }
  ])
