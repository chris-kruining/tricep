import * as common from '../base/app-service.bicep'
import { Context } from '../types.bicep'

@export()
func appService(context Context, appServicePlan string, vnetName string, appInsights string, options Options) object =>
  common.appService(
    context,
    union(
      [
        common.withSiteConfig(appServicePlan, vnetName, true, true, '1.2', 'Deny', false)
        common.withAppSettings([
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
        common.withIpRestrictions([
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
func withAlwaysOn(alwaysOn bool) object => common.withAlwaysOn(alwaysOn)

@export()
func withAppSettings(appSettings common.AppSetting[]) object => common.withAppSettings(appSettings)

@export()
func withConnectionStrings(connectionStrings common.ConnStringInfo[]) object =>
  common.withConnectionStrings(connectionStrings)

@export()
func withAllowManagementVm(managementSubNet string) object =>
  common.withIpRestrictions([
    {
      name: 'Allow management vm'
      vnetSubnetResourceId: managementSubNet
      priority: 100
      action: 'Allow'
    }
  ])
