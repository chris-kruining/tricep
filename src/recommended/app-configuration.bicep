import * as base from '../base/app-configuration.bicep'
import { Context, Options } from '../types.bicep'

@export()
func appConfiguration(context Context, options Options) object => base.appConfiguration(context, 'Standard', options)

@export()
func withFreeSku() object => base.withSku('Free')
