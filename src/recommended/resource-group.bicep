import { Context, Options } from '../types.bicep'
import * as common from '../base/resource-group.bicep'

@export()
func resourceGroup(context Context, options Options) object => common.resourceGroup(context, options)
