import { Context, Options } from '../types.bicep'
import * as common from '../base/container-app.bicep'

@export()
func containerApp(context Context, options Options) object => common.containerApp(context, options)

@export()
func containerAppEnvironment(context Context, options Options) object =>
  common.containerAppEnvironment(context, 'Consumption', options)
