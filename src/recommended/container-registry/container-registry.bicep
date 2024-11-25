import { Context, Options } from '../../types.bicep'
import * as base from '../../base/container-registry/container-registry.bicep'

@export()
func container_registry(context Context, options Options) object =>
  base.container_registry(context, 'Standard', options)

@export()
func with_basic_sky() object => base.with_sku('Basic')

@export()
func with_classic_sky() object => base.with_sku('Classic')

@export()
func with_premium_sky() object => base.with_sku('Premium')
