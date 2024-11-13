import { createContext } from '../../../src/common/context.bicep'
import { resourceGroup } from '../../../src/recommended/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string

var context = createContext({
  name: 'appName'
  nameConventionTemplate: '$type-$env-$loc-$name'
  environment: 'shared'
  location: 'westeurope'
  deployedAt: deployedAt
  tenant: tenant()
})
