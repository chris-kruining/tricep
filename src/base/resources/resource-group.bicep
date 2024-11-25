import { Context, Options } from '../../types.bicep'
import { create_resource } from '../../internal/resource.bicep'

@export()
func resource_group(context Context, options Options) object => create_resource(context, 'resourceGroup', options)
