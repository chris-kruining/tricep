# tricep
A library of compositional functions to aid in the creation of config for resources.

This library, by design, does not create any resouces for you.

## Examples
See the `example` directory for some use cases on how to utilize Tricep

## Design
*TODO*

## Limitations / Known errors / Gotcha's

### composition with dynamic bicep functions
Bicep has a bunch of functions that need to run during "runtime".  
For example `reference`, `listKeys`, or `listCallbackUrl`.

The use of such a function causes the whole expression tree to be hoisted to the generated ARM template.  
For a resources `properties` this is a-ok. The `name`, `locaton`, and `tags` however 
need to be resolved when generating the ARM template.

This means that we need to split the code that created the `name`, `locaton`, and `tags` properties from the code that creates the `properties` property.

This is where the `__dynamic` function from the utilities comes in. This function replicates the composition normally done in an internal function in Tricep, but just retruns the `properties`'s value.

An example to illustrate what I mean:

**Don't do this**
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

**Instead do this**
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