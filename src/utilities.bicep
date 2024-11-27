import { Options } from './types.bicep'

@export()
@description('''
Compose resouce properties when using dynamic functions
---

`__dynamic` aids in resource property composition.
Right now bicep/ARM has a limitation where the whole expression  
is made dynamic once a dynamic function is used somewhere in the tree.

since the name, location, and tags of a resouce may not be dynamic you will get [error BCP120](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-core-diagnostics#BCP120) when you  
apply the config to the resource.

`__dynamic` has the same composition logic as the internal `create_resource` function does.  

### Example
#### Don't do this
```bicep
import { Context } from '../../../src/types.bicep'
import { action_group, with_receiver } from '../../../src/recommended/insights/action-group.bicep'

targetScope = 'resourceGroup'

param context Context
param alertLogicAppId string

var actionGroupConfig = action_group(context, 'Alerts', [
  with_receiver('logicApp', {
    name: 'Alert messages logic app'
    resourceId: alertLogicAppId
    callbackUrl: listCallbackUrl(alertLogicAppId, '2019-05-01').value
    useCommonAlertSchema: true
  })
])

resource actionGroup 'microsoft.insights/actionGroups@2023-09-01-preview' = {
  name: actionGroupConfig.name
  location: actionGroupConfig.location
  tags: actionGroupConfig.tags
  properties: actionGroupConfig.properties
}
```

#### Instead do this
```bicep
import { Context } from '../../../src/types.bicep'
import { __dynamic } from '../../../src/utilities.bicep'
import { action_group, with_receiver } from '../../../src/recommended/insights/action-group.bicep'

targetScope = 'resourceGroup'

param context Context
param alertLogicAppId string

var actionGroupConfig = action_group(context, 'Alerts', [])

resource actionGroup 'microsoft.insights/actionGroups@2023-09-01-preview' = {
  name: actionGroupConfig.name
  location: actionGroupConfig.location
  tags: actionGroupConfig.tags
  properties: __dynamic(actionGroupConfig, [
    with_receiver('logicApp', {
      name: 'Alert messages logic app'
      resourceId: alertLogicAppId
      callbackUrl: listCallbackUrl(alertLogicAppId, '2019-05-01').value
      useCommonAlertSchema: true
    })
  ])
}
```

### Dev note
I hate `__dynamic`. i kind of ruined my -imo- elegant API design.  
but a limitation is a limitation, and therefor requires a workaround

If it turns out that `__dynamic` will show up everywhere in my code where I use Tricep,  
then I'll re-design the API to not need `__dynamic` anymore.
Until then this will have to suffice.
''')
func __dynamic(resource object, options Options) object =>
  reduce(options, resource, (obj, next) => union(obj, next)).properties
