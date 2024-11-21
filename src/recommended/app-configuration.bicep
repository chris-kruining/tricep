import * as base from '../base/app-configuration.bicep'
import { Context, Options } from '../types.bicep'

@export()
func app_configuration(context Context, options Options) object => base.app_configuration(context, 'Standard', options)

@export()
func withFreeSku() object => base.with_sku('Free')
