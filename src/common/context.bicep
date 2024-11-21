import { Context, Location, Tags, Tenant } from '../types.bicep'

@export()
func create_context(params create_contextParams) Context => {
  name: params.name
  project: params.project
  nameConventionTemplate: params.nameConventionTemplate
  environment: params.environment
  location: params.location
  tenant: params.tenant
  tags: {
    application: params.name
    deployedAt: params.deployedAt
    environment: params.environment
    location: params.location
    deploymentMethod: 'Bicep'
    ...params.tags
  }
}

type create_contextParams = {
  name: string
  project: string
  nameConventionTemplate: string
  deployedAt: string
  environment: string
  location: Location
  tenant: Tenant
  tags: Tags
}

@export()
func with_name(context Context, name string) Context => {
  ...context
  name: name
}
