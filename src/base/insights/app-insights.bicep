import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func app_insights(context Context, options Options) object => create_resource(context, 'applicationInsights', options)
