@export()
type Context = {
  name: string
  template: string
  environment: string
  location: Location
  tags: Tags
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
  | 'containerRegistry'
  | 'containerAppEnvironment'

@export()
type Abbreviation =
  | 'rg'
  | 'ca'
  | 'cae'
  | 'kv'
  | 'id'
  | 'stapp'
  | 'app'
  | 'cr'
  | 'cae'
  | 'cae'
  | 'cae'
  | 'cae'
  | 'cae'
  | 'cae'
