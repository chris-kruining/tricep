@export()
@minValue(0)
@maxValue(4294967295)
type uint32 = int

@export()
@minValue(-2147483648)
@maxValue(2147483647)
type int32 = int

@export()
@minValue(0)
@maxValue(65535)
type uint16 = int

@export()
@minValue(-32768)
@maxValue(32767)
type int16 = int

@export()
@minValue(0)
@maxValue(255)
type uint8 = int

@export()
@minValue(-128)
@maxValue(127)
type int8 = int

@export()
type Context = {
  project: string
  nameConventionTemplate: string
  environment: string
  location: Location
  tenant: Tenant
  tags: Tags
}

@description('this is bicep\'s own tenant, there just isn\'t a type for it')
@export()
type Tenant = {
  countryCode: string
  displayName: string
  tenantId: string
}

@export()
type Tags = {
  *: string
}

@export()
type Location =
  | 'southafricanorth'
  | 'southafricawest'
  | 'australiacentral'
  | 'australiacentral2'
  | 'australiaeast'
  | 'australiasoutheast'
  | 'centralindia'
  | 'eastasia'
  | 'japaneast'
  | 'japanwest'
  | 'jioindiacentral'
  | 'jioindiawest'
  | 'koreacentral'
  | 'koreasouth'
  | 'southindia'
  | 'southeastasia'
  | 'westindia'
  | 'canadacentral'
  | 'canadaeast'
  | 'francecentral'
  | 'francesouth'
  | 'germanynorth'
  | 'germanywestcentral'
  | 'italynorth'
  | 'northeurope'
  | 'norwayeast'
  | 'norwaywest'
  | 'polandcentral'
  | 'spaincentral'
  | 'swedencentral'
  | 'switzerlandnorth'
  | 'switzerlandwest'
  | 'uksouth'
  | 'ukwest'
  | 'westeurope'
  | 'mexicocentral'
  | 'israelcentral'
  | 'qatarcentral'
  | 'uaecentral'
  | 'uaenorth'
  | 'brazilsouth'
  | 'brazilsoutheast'
  | 'brazilus'
  | 'centralus'
  | 'centraluseuap'
  | 'eastus'
  | 'eastus2'
  | 'eastus2euap'
  | 'eastusstg'
  | 'northcentralus'
  | 'southcentralus'
  | 'southcentralusstg'
  | 'westcentralus'
  | 'westus'
  | 'westus2'
  | 'westus3'

@export()
type Options = object[]

@export()
type ResourceType =
  | 'resourceGroup'
  | 'containerApp'
  | 'containerAppEnvironment'
  | 'keyVault'
  | 'managedIdentity'
  | 'staticWebApp'
  | 'appService'
  | 'appServicePlan'
  | 'containerRegistry'
  | 'appConfiguration'
  | 'serviceBus'
  | 'serviceBusQueue'
  | 'serviceBusTopic'
  | 'serviceBusTopicSubscription'
  | 'applicationInsights'
  | 'storageAccount'
  | 'logAnalytics'

@export()
type Abbreviation =
  | 'rg'
  | 'ca'
  | 'cae'
  | 'kv'
  | 'id'
  | 'stapp'
  | 'app'
  | 'asp'
  | 'cr'
  | 'appcs'
  | 'sb'
  | 'sbq'
  | 'sbt'
  | 'sbts'
  | 'appi'
  | 'st'
  | 'la'
