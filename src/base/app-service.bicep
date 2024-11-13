import { createResource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@export()
func appService(context Context, options Options) object => createResource(context, 'appService', options)


// Always on
@export()
func withAlwaysOn(alwaysOn bool) object => {
  properties: {
    siteConfig: {
      alwaysOn: alwaysOn
    }
  }
}

// Site configuration
@export()
func withSiteConfig(
  appServicePlan string,
  vnetName string,
  vnetRouteAllEnabled bool,
  httpsOnly bool,
  minTlsVersion TLSVersion,
  defaultIpRestrictionAction IpSecurityRestrictionAction,
  scmIpSecurityRestrictionsUseMain bool
) object => {
  properties: {
    serverFarmId: appServicePlan
    httpsOnly: httpsOnly
    vnetRouteAllEnabled: vnetRouteAllEnabled
    siteConfig: {
      virtualNetworkSubnetId: vnetName
      minTlsVersion: minTlsVersion
      ipSecurityRestrictionsDefaultAction: defaultIpRestrictionAction
      scmIpSecurityRestrictionsUseMain: scmIpSecurityRestrictionsUseMain
    }
  }
}

@export()
type TLSVersion = '1.0' | '1.1' | '1.2'

@export()
type IpSecurityRestrictionAction = 'Allow' | 'Deny'

// App settings
@export()
func withIpRestrictions(ipRestrictions IpSecurityRestriction[]) object => {
  properties: {
    siteConfig: {
      ipSecurityRestrictions: ipRestrictions
    }
  }
}

@export()
type IpSecurityRestriction = {
  action: IpSecurityRestrictionAction
  name: string
  vnetSubnetResourceId: string
  priority: int
}

// App settings
@export()
func withAppSettings(appSettings AppSetting[]) object => {
  properties: {
    siteConfig: {
      appSettings: appSettings
    }
  }
}

@export()
type AppSetting = {
  name: string
  value: string
}

// Connections strings
@export()
func withConnectionStrings(connectionStrings ConnStringInfo[]) object => {
  properties: {
    siteConfig: {
      connectionStrings: connectionStrings
    }
  }
}

@export()
type ConnStringInfo = {
  connectionString: string
  name: string
  type:
    | 'ApiHub'
    | 'Custom'
    | 'DocDb'
    | 'EventHub'
    | 'MySql'
    | 'NotificationHub'
    | 'PostgreSQL'
    | 'RedisCache'
    | 'SQLAzure'
    | 'SQLServer'
    | 'ServiceBus'
}
