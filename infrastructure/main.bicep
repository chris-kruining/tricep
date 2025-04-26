targetScope = 'subscription'

param deployedAt string = utcNow('yyyyMMdd')

var locationAbbreviation = 'euw'
var location = 'west europe'
var environment = 'prd'
var projectName = 'tricep'

var context = {
  locationAbbreviation: locationAbbreviation
  location: location
  environment: environment
  projectName: projectName
  deployedAt: deployedAt
}

resource calqueResourceGroup 'Microsoft.Resources/resourceGroups@2025-03-01' = {
  name: 'rg-${locationAbbreviation}-${environment}-${projectName}'
  location: location
}

module registry 'registry.bicep' = {
  name: 'registry'
  scope: calqueResourceGroup
  params: {
    context: context
  }
}
