import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func app_insights(context Context, kind string, workspaceId string, options Options) object =>
  create_resource(
    context,
    'applicationInsights',
    union([{ kind: kind, properties: { Application_Type: 'web', WorkspaceResourceId: workspaceId } }], options)
  )

@export()
type ApplicationInsightsComponentProperties = {
  @description('Type of application being monitored.')
  Application_Type: 'web' | 'other'

  @description('Disable IP masking.')
  DisableIpMasking: bool?

  @description('Disable Non-AAD based Auth.')
  DisableLocalAuth: bool?

  @description('Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to \'Bluefield\' when creating/updating a component via the REST API.')
  Flow_Type: 'Bluefield'?

  @description('Force users to create their own storage account for profiler and debugger.')
  ForceCustomerStorageForProfiler: bool?

  @description('The unique application ID created when a new application is added to HockeyApp, used for communications with HockeyApp.')
  HockeyAppId: string?

  @description('Purge data immediately after 30 days.')
  ImmediatePurgeDataOn30Days: bool?

  @description('Indicates the flow of the ingestion.')
  IngestionMode: ('ApplicationInsights' | 'ApplicationInsightsWithDiagnosticSettings' | 'LogAnalytics')?

  @description('The network access type for accessing Application Insights ingestion.')
  publicNetworkAccessForIngestion: ('Disabled' | 'Enabled')?

  @description('The network access type for accessing Application Insights query.')
  publicNetworkAccessForQuery: ('Disabled' | 'Enabled')?

  @description('Describes what tool created this Application Insights component. Customers using this API should set this to the default \'rest\'.')
  Request_Source: 'rest'?

  @description('Retention period in days.')
  RetentionInDays: int

  @description('Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry. To specify a decimal value, use the json() function.')
  SamplingPercentage: string

  @description('Resource Id of the log analytics workspace which the data will be ingested to. This property is required to create an application with this API version. Applications from older versions will not have this property.')
  WorkspaceResourceId: string
}
