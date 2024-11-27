import { Context } from '../../../src/types.bicep'
import { with_managed_identity } from '../../../src/common/identity.bicep'
import { workflow } from '../../../src/recommended/logic/workflow.bicep'

targetScope = 'resourceGroup'

param context Context

var workflowConfig = workflow(context, loadJsonContent('./alert-app.json'), [
  with_managed_identity()
])

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: workflowConfig.name
  location: workflowConfig.location
  tags: workflowConfig.tags
  identity: workflowConfig.identity
  properties: workflowConfig.properties
}

output logicApp resource'Microsoft.Logic/workflows@2019-05-01' = logicApp
