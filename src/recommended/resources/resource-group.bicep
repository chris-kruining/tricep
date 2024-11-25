import { Context, Options } from '../../types.bicep'
import * as base from '../../base/resources/resource-group.bicep'

@export()
func resource_group(context Context, options Options) object => base.resource_group(context, options)
