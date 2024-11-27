@export()
@description('''
Apply system assigned managed identity to the current config
---

```bicep{2,10,17}
import { Context } from 'br/Tricep:types:latest'
import { with_managed_identity } from 'br/Tricep:common/identity:latest'
import { workflow } from 'br/Tricep:recommended/logic/workflow:latest'

targetScope = 'resourceGroup'

param context Context

var workflowConfig = workflow(context, [
  with_managed_identity()
])

resource sendMessageOverTeamsAndSlack 'Microsoft.Logic/workflows@2019-05-01' = {
  name: workflowConfig.name
  location: workflowConfig.location
  tags: workflowConfig.tags
  identity: workflowConfig.identity
  properties: workflowConfig.properties
}
```
''')
func with_managed_identity() object => {
  identity: {
    type: 'SystemAssigned'
  }
}
