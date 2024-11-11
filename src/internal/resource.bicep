import { Context } from '../types.bicep'
import { createName } from './name.bicep'

@export()
func createResource(context Context, resourceType string, options object[]) object =>
  reduce(
    options,
    {
      name: createName(
        {
          enc: context.environment
          loc: context.location
        },
        context.template
      )
    },
    (obj, next) => union(obj, next)
  )
