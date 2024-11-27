import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
@description('define a [logic app workflow](https://learn.microsoft.com/en-us/azure/templates/microsoft.logic/workflows) resource')
func workflow(context Context, definition object, options Options) object =>
  create_resource(
    context,
    'workflow',
    union(
      [
        {
          properties: {
            definition: definition
          }
        }
      ],
      options
    )
  )

@export()
type WorkflowProperties = {
  @description('The access control configuration.')
  accessControl: FlowAccessControlConfiguration?

  @description('The definition. See [Schema reference for Workflow Definition Language in Azure Logic Apps](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-workflow-definition-language).')
  definition: object?

  @description('The endpoints configuration.')
  endpointsConfiguration: FlowEndpointsConfiguration?

  @description('The integration account.')
  integrationAccount: ResourceReference?

  @description('The integration service environment.')
  integrationServiceEnvironment: ResourceReference?

  @description('The parameters.')
  parameters: object?

  @description('The state.')
  state: ('Completed' | 'Deleted' | 'Disabled' | 'Enabled' | 'NotSpecified' | 'Suspended')?
}

@export()
type FlowAccessControlConfiguration = {
  @description('The access control configuration for workflow actions.')
  actions: FlowAccessControlConfigurationPolicy?

  @description('The access control configuration for accessing workflow run contents.')
  contents: FlowAccessControlConfigurationPolicy?

  @description('The access control configuration for invoking workflow triggers.')
  triggers: FlowAccessControlConfigurationPolicy?

  @description('The access control configuration for workflow management.')
  workflowManagement: FlowAccessControlConfigurationPolicy?
}

@export()
type FlowAccessControlConfigurationPolicy = {
  @description('The allowed caller IP address ranges.')
  allowedCallerIpAddresses: IpAddressRange[]?

  @description('The authentication policies for workflow.')
  openAuthenticationPolicies: OpenAuthenticationAccessPolicies?
}

@export()
type IpAddressRange = {
  @description('The IP address range.')
  addressRange: string?
}

@export()
type OpenAuthenticationAccessPolicies = {
  @description('Open authentication policies.')
  policies: OpenAuthenticationAccessPolicies?
}

@export()
type FlowEndpointsConfiguration = {
  @description('The connector endpoints.')
  connector: FlowEndpoints?

  @description('The workflow endpoints.')
  workflow: FlowEndpoints?
}

@export()
type FlowEndpoints = {
  @description('The access endpoint ip address.')
  accessEndpointIpAddresses: IpAddress[]?

  @description('The outgoing ip address.')
  outgoingIpAddresses: IpAddress[]?
}

@export()
type IpAddress = {
  @description('The address.')
  address: string?
}

@export()
type ResourceReference = {
  @description('The resource id.')
  id: string?
}
