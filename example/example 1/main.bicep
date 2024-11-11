import { createContext } from '../../src/context.bicep'
import { resourceGroup } from '../../src/recommended/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string = utcNow('yyyyMMdd')

var context = createContext('$type-$env-template-$name', 'dev', 'weu')

var template = '$type-$env-template-$name'
var params = {
  env: 'dev'
  type: 'rg'
  name: 'some-group'
}
var name = createName(params, template)

var resourceGroupConfig = resourceGroup(context)
;
resource group 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: name
  location: 'westEurope'
  tags: {
    deployedAt: deployedAt
  }
  managedBy: 'Chris'
  properties: {}
}

func createName(context object, template string) string =>
  reduce(items(context), template, (t, e) => replace(string(t), '$${e.key}', e.value))

output name string = name
