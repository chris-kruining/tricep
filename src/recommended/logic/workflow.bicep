import * as base from '../../base/logic/workflow.bicep'
import { Context, Options } from '../../types.bicep'

@export()
@description('''
## Define a [logic app workflow](https://learn.microsoft.com/en-us/azure/templates/microsoft.logic/workflows) resource

**Example**
```bicep
import { Context } from 'br/Tricep:types:latest'
import { workflow } from 'br/Tricep:recommended/logic/workflow:latest'

param context Context

var workflowConfig = workflow(context, []);

resource someWorkflowResource 'Microsoft.Logic/workflows@2019-05-01' = {
  name: workflowConfig.name
  location: workflowConfig.location
  tags: workflowConfig.tags
  identity: workflowConfig.identity
  properties: workflowConfig.properties
}
```
''')
func workflow(context Context, definition object, options Options) object => base.workflow(context, definition, options)
