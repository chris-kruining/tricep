import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func action_group(context Context, name string, options Options) object =>
  create_resource(
    context,
    'actionGroup',
    union(
      [
        {
          location: 'global'
          properties: {
            groupShortName: name
            enabled: true
            emailReceivers: []
            smsReceivers: []
            webhookReceivers: []
            eventHubReceivers: []
            itsmReceivers: []
            azureAppPushReceivers: []
            automationRunbookReceivers: []
            voiceReceivers: []
            logicAppReceivers: []
            azureFunctionReceivers: []
            armRoleReceivers: []
          }
        }
      ],
      options
    )
  )
