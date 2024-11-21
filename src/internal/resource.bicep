import { Context, ResourceType } from '../types.bicep'
import { create_name, to_resource_abbreviation, to_location_abbreviation } from './name.bicep'

@export()
func create_resource(context Context, resourceType ResourceType, options object[]) object =>
  reduce(
    options,
    {
      name: create_name(
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
