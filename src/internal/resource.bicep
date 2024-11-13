import { Context, ResourceType } from '../types.bicep'
import { createName, to_resource_abbreviation, to_location_abbreviation } from './name.bicep'

@export()
func createResource(context Context, resourceType ResourceType, options object[]) object =>
  reduce(
    options,
    {
      name: createName(
        {
          env: context.environment
          loc: to_location_abbreviation(context.location)
          type: to_resource_abbreviation(resourceType)
          name: context.name
        },
        context.nameConventionTemplate
      )
      location: context.location
      tags: context.tags
      properties: {}
    },
    (obj, next) => union(obj, next)
  )
