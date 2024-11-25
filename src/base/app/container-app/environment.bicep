import { create_resource } from '../../../internal/resource.bicep'
import { Context, Options, Tags } from '../../../types.bicep'

@export()
func container_app_environment(context Context, options Options) object =>
  create_resource(
    context,
    'containerAppEnvironment',
    concat(
      [
        {}
      ],
      options
    )
  )

type ManagedEnvironments = {
  name: string
  location: string
  tags: { *: string }
  kind: string
  properties: ManagedEnvironmentProperties
}

type ManagedEnvironmentProperties = {
  @description('Cluster configuration which enables the log daemon to export app logs to a destination. Currently only "log-analytics" is supported.')
  appLogsConfiguration: AppLogsConfiguration

  @description('Custom domain configuration for the environment.')
  customDomainConfiguration: CustomDomainConfiguration

  @description('Application Insights connection string used by Dapr to export Service to Service communication telemetry.')
  @secure()
  daprAIConnectionString: string

  @description('Azure Monitor instrumentation key used by Dapr to export Service to Service communication telemetry.')
  @secure()
  daprAIInstrumentationKey: string

  @description('The configuration of Dapr component.')
  daprConfiguration: DaprConfiguration

  @description('Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. If a subnet ID is provided, this resource group will be created in the same subscription as the subnet.')
  infrastructureResourceGroup: string

  @description('The configuration of Keda component.')
  kedaConfiguration: KedaConfiguration

  @description('Peer authentication settings for the Managed Environment.')
  peerAuthentication: ManagedEnvironmentPropertiesPeerAuthentication

  @description('Peer traffic settings for the Managed Environment.')
  peerTrafficConfiguration: ManagedEnvironmentPropertiesPeerTrafficConfiguration

  @description('Vnet configuration for the environment.')
  vnetConfiguration: VnetConfiguration

  @description('Workload profiles configured for the Managed Environment.')
  workloadProfiles: WorkloadProfile[]

  @description('Whether or not this Managed Environment is zone-redundant.')
  zoneRedundant: bool
}

type AppLogsConfiguration = {
  @description('Logs destination, can be \'log-analytics\', \'azure-monitor\' or \'none\'.')
  destination: 'log-analytics' | 'azure-monitor' | 'none'

  @description('Log Analytics configuration, must only be provided when destination is configured as \'log-analytics\'.')
  logAnalyticsConfiguration: LogAnalyticsConfiguration
}

type LogAnalyticsConfiguration = {
  @description('Log analytics customer id.')
  customerId: string

  @description('Log analytics customer key.')
  @secure()
  sharedKey: string
}

type CustomDomainConfiguration = {
  @description('Certificate password.')
  @secure()
  certificatePassword: string

  @description('PFX or PEM blob (DO NOT USE, string is not the proper type).')
  certificateValue: string

  @description('Dns suffix for the environment domain.')
  dnsSuffix: string
}

type DaprConfiguration = {}

type KedaConfiguration = {}

type ManagedEnvironmentPropertiesPeerAuthentication = {
  @description('Mutual TLS authentication settings for the Managed Environment.')
  mtls: Mtls
}

type Mtls = {
  @description('Boolean indicating whether the mutual TLS authentication is enabled.')
  enabled: bool
}

type ManagedEnvironmentPropertiesPeerTrafficConfiguration = {
  @description('Peer traffic encryption settings for the Managed Environment.')
  encryption: ManagedEnvironmentPropertiesPeerTrafficConfigurationEncryption
}

type ManagedEnvironmentPropertiesPeerTrafficConfigurationEncryption = {
  @description('Boolean indicating whether the peer traffic encryption is enabled.')
  enabled: bool
}

type VnetConfiguration = {
  @description('CIDR notation IP range assigned to the Docker bridge, network. Must not overlap with any other provided IP ranges.')
  dockerBridgeCidr: string

  @description('Resource ID of a subnet for infrastructure components. Must not overlap with any other provided IP ranges.')
  infrastructureSubnetId: string

  @description('Boolean indicating the environment only has an internal load balancer. These environments do not have a public static IP resource. They must provide infrastructureSubnetId if enabling this property.')
  internal: bool

  @description('IP range in CIDR notation that can be reserved for environment infrastructure IP addresses. Must not overlap with any other provided IP ranges.')
  platformReservedCidr: string

  @description('An IP address from the IP range defined by platformReservedCidr that will be reserved for the internal DNS server.')
  platformReservedDnsIP: string
}

type WorkloadProfile = {
  @description('The maximum capacity.')
  maximumCount: int?

  @description('The minimum capacity.')
  minimumCount: int?

  @description('name of the workload')
  name: string

  @description('Workload profile type for the workloads to run on.')
  workloadProfileType: string
}
