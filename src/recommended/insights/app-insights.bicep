import * as base from '../../base/insights/app-insights.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func app_insights(context Context, workspaceId string, options Options) object =>
  base.app_insights(context, 'web', workspaceId, options)
