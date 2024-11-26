import { Context } from '../../../src/types.bicep'

targetScope = 'resourceGroup'

param context Context

resource workflow 'Microsoft.Logic/workflows@2019-05-01' existing = {
  name: 'test'
}

output id string = workflow.id
output url string = workflow.listCallbackUrl().value
