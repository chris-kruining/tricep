import { Context, Options } from '../../types.bicep'
import * as base from '../../base/container-registry/container-registry.bicep'

@export()
func container_registry(context Context, options Options) object =>
  base.container_registry(context, 'Standard', options)
