import { Context, Options } from '../types.bicep'
import * as common from '../base/container-registry.bicep'

@export()
func containerRegistry(context Context, options Options) object =>
  common.containerRegistry(context, 'Standard', options)
