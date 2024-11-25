import { Context, Location, Tags, Tenant } from '../types.bicep'

@export()
func create_context(params CreateContextParams) Context => {
  project: params.project
  nameConventionTemplate: params.nameConventionTemplate
  environment: params.environment
  location: params.location
  tenant: params.tenant
  tags: {
    project: params.project
    deployedAt: params.deployedAt
    environment: params.environment
    location: params.location
    deploymentMethod: 'Bicep'
    ...params.tags
  }
}

type CreateContextParams = {
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
  nameConventionTemplate: '${context.nameConventionTemplate}-${name}'
}
