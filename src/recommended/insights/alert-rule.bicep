import * as base from '../../base/insights/alert-rule.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func alert_rule(context Context, name string, isEnabled bool, condition base.RuleCondition, options Options) object =>
  base.alert_rule(context, name, isEnabled, condition, options)

@export()
func create_threshold_condition(
  operator base.ThresholdRuleCondition.operator,
  threshold base.ThresholdRuleCondition.threshold
) base.ThresholdRuleCondition => {
  'odata.type': 'Microsoft.Azure.Management.Insights.Models.ThresholdRuleCondition'
  operator: operator
  threshold: threshold
}
