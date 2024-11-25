import * as base from '../../base/insights/alert-rule.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func alert_rule(context Context, name string, isEnabled bool, condition base.RuleCondition, options Options) object =>
  base.alert_rule(context, name, isEnabled, condition, options)
