import * as base from '../../base/insights/action-group.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func action_group(context Context, name string, options Options) object => base.action_group(context, name, options)

@export()
func with_receiver(type ReceiverType, receiver object) object => {
  properties: {
    '${type}Receivers': [receiver]
  }
}

type ReceiverType =
  | 'email'
  | 'sms'
  | 'webhook'
  | 'eventHub'
  | 'itsm'
  | 'azureAppPush'
  | 'automationRunbook'
  | 'voice'
  | 'logicApp'
  | 'azureFunction'
  | 'armRole'
