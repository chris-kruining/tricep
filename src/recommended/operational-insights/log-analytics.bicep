import { Context, Options } from '../../types.bicep'
import * as base from '../../base/operational-insights/log-analytics.bicep'

@export()
func log_analytics(context Context, options Options) object => base.log_analytics(context, 'PerGB2018', options)
