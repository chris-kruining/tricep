import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func app_service(context Context, options Options) object => create_resource(context, 'appService', options)

// Always on
@export()
func with_always_on(alwaysOn bool) object => {
  properties: {
    siteConfig: {
      alwaysOn: alwaysOn
    }
  }
}

// Site configuration
@export()
func with_site_config(
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
func with_ip_restrictions(ipRestrictions IpSecurityRestriction[]) object => {
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
func with_app_settings(appSettings AppSetting[]) object => {
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
func with_connection_strings(connectionStrings ConnStringInfo[]) object => {
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
