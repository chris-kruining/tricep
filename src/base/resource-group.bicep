import { Context, Options } from '../types.bicep'
import { createResource } from '../internal/resource.bicep'

@export()
func resourceGroup(context Context, options Options) object => createResource(context, 'resourceGroup', options)
