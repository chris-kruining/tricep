import { create_context } from '../../../src/common/context.bicep'
import { resource_group } from '../../../src/recommended/resources/resource-group.bicep'

targetScope = 'subscription'

param deployedAt string

var context = create_context({
  name: 'appName'
  project: 'project'
  nameConventionTemplate: '$type-$environment-$location-$name'
  environment: 'shared'
  location: 'westeurope'
  deployedAt: deployedAt
  tenant: tenant()
  tags: {}
})
