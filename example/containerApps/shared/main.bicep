import { create_context } from '../../../src/common/context.bicep'
import { resource_group } from '../../../src/recommended/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string

var context = create_context({
  name: 'appName'
  nameConventionTemplate: '$type-$env-$loc-$name'
  environment: 'shared'
  location: 'westeurope'
  deployedAt: deployedAt
  tenant: tenant()
  tags: {}
})
