import { Context, Options } from '../../types.bicep'
import * as base from '../../base/container-registry/container-registry.bicep'

@export()
func container_registry(context Context, options Options) object =>
  base.container_registry(context, 'Standard', options)

@export()
@description('DEPRECATED, either remove this function call to use standard, or change "basic" to "classic" or "premium"')
func with_basic_sky() object => base.with_sku('Basic')

@export()
func with_classic_sky() object => base.with_sku('Classic')

@export()
func with_premium_sky() object => base.with_sku('Premium')
