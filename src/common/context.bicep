import { Context, Location, Tags, Tenant } from '../types.bicep'

@export()
func createContext(params CreateContextParams) Context => {
  name: params.name
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

type CreateContextParams = {
  name: string
  nameConventionTemplate: string
  deployedAt: string
  environment: string
  location: Location
  tenant: Tenant
  tags: Tags
}
