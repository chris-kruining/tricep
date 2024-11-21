import { create_resource } from '../internal/resource.bicep'
import { Context, Options, Tags } from '../types.bicep'

import { container_app_environment } from 'container-app/environment.bicep'

@export()
func container_app(context Context, containers Container[], options Options) object =>
  create_resource(
    context,
    'containerApp',
    union(
      [
        {
          properties: {
            template: {
              containers: containers
            }
          }
        }
      ],
      options
    )
  )

@export()
type ContainerApp = {
  @description('The resource name.')
  @minLength(2)
  @maxLength(32)
  name: string

  @description('The geo-location where the resource lives.')
  location: string

  @description('Resource tags.')
  tags: Tags?

  @description('The complex type of the extended location.')
  extendedLocation: ExtendedLocation?

  @description('managed identities for the Container App to interact with other Azure services without maintaining any secrets or credentials in code.')
  identity: ManagedServiceIdentity?

  @description('The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.')
  managedBy: string?

  @description('ContainerApp resource specific properties	')
  properties: ContainerAppProperties?
}

type ExtendedLocation = {
  @description('The name of the extended location.')
  name: string?

  @description('The type of the extended location.')
  type: 'CustomLocation'?
}

type ManagedServiceIdentity = {
  @description('Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).')
  type: 'None' | 'SystemAssigned' | 'SystemAssigned,UserAssigned' | 'UserAssigned'

  @description('The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: \'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.')
  userAssignedIdentities: UserAssignedIdentities?
}

type UserAssignedIdentities = {
  *: UserAssignedIdentity
}

type UserAssignedIdentity = {}

type ContainerAppProperties = {
  @description('Non versioned Container App configuration properties.')
  configuration: Configuration?

  @description('Resource ID of environment.')
  environmentId: string?

  @description('Container App versioned application definition.')
  template: Template?

  @description('Workload profile name to pin for container app execution.')
  workloadProfileName: string?
}

type Configuration = {
  @description('ActiveRevisionsMode controls how active revisions are handled for the Container app: {list}{item}Multiple: multiple revisions can be active.{/item}{item}Single: Only one revision can be active at a time. Revision weights can not be used in this mode. If no value if provided, this is the default.{/item}{/list}')
  activeRevisionsMode: 'Multiple' | 'Single'?

  @description('Dapr configuration for the Container App.')
  dapr: Dapr?

  @description('Ingress configurations.')
  ingress: Ingress?

  @description('Optional. Max inactive revisions a Container App can have.')
  maxInactiveRevisions: int?

  @description('Collection of private container registry credentials for containers used by the Container app.')
  registries: RegistryCredentials[]?

  @description('Collection of secrets used by a Container app.')
  secrets: Secret[]?

  @description('Container App to be a dev Container App Service.')
  service: Service?
}

type Dapr = {
  @description('Dapr application identifier.')
  appId: string?

  @description('Tells Dapr which port your application is listening on.')
  appPort: int?

  @description('Tells Dapr which protocol your application is using. Valid options are http and grpc. Default is http.')
  appProtocol: 'grpc' | 'http'?

  @description('Enables API logging for the Dapr sidecar.')
  enableApiLogging: bool?

  @description('Boolean indicating if the Dapr side car is enabled.')
  enabled: bool?

  @description('Increasing max size of request body http and grpc servers parameter in MB to handle uploading of big files. Default is 4 MB.')
  httpMaxRequestSize: int?

  @description('Dapr max size of http header read buffer in KB to handle when sending multi-KB headers. Default is 65KB.')
  httpReadBufferSize: int?

  @description('Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.')
  logLevel: 'debug' | 'error' | 'info' | 'warn'?
}

type Ingress = {
  @description('.')
  additionalPortMappings: IngressPortMapping[]?

  @description('.')
  allowInsecure: bool?

  @description('.')
  clientCertificateMode: 'accept' | 'ignore' | 'require'?

  @description('.')
  corsPolicy: CorsPolicy?

  @description('.')
  customDomains: CustomDomain[]?

  @description('.')
  exposedPort: int?

  @description('.')
  external: bool?

  @description('.')
  ipSecurityRestrictions: IpSecurityRestrictionRule[]?

  @description('.')
  stickySessions: IngressStickySessions?

  @description('.')
  targetPort: int?

  @description('.')
  traffic: TrafficWeight[]?

  @description('.')
  transport: 'auto' | 'http' | 'http2' | 'tcp'?
}

type IngressPortMapping = {
  @description('Specifies the exposed port for the target port. If not specified, it defaults to target port.')
  exposedPort: int?

  @description('Specifies whether the app port is accessible outside of the environment.')
  external: bool

  @description('Specifies the port user\'s container listens on.')
  targetPort: int
}

type CorsPolicy = {
  @description('Specifies whether the resource allows credentials.')
  allowCredentials: bool?

  @description('Specifies the content for the access-control-allow-headers header.')
  allowedHeaders: string[]?

  @description('Specifies the content for the access-control-allow-methods header.')
  allowedMethods: string[]?

  @description('Specifies the content for the access-control-allow-origins header.')
  allowedOrigins: string[]

  @description('Specifies the content for the access-control-expose-headers header.')
  exposeHeaders: string[]?

  @description('Specifies the content for the access-control-max-age header.')
  maxAge: int?
}

type CustomDomain = {
  @description('Custom Domain binding type.')
  bindingType: 'Disabled' | 'SniEnabled'?

  @description('Resource Id of the Certificate to be bound to this hostname. Must exist in the Managed Environment.')
  certificateId: string?

  @description('Hostname.')
  name: string
}

type IpSecurityRestrictionRule = {
  @description('Allow or Deny rules to determine for incoming IP. Note: Rules can only consist of ALL Allow or ALL Deny.')
  action: 'Allow' | 'Deny'

  @description('Describe the IP restriction rule that is being sent to the container-app. This is an optional field.')
  description: string?

  @description('CIDR notation to match incoming IP address.')
  ipAddressRange: string

  @description('Name for the IP restriction rule.')
  name: string
}

type IngressStickySessions = {
  @description('Sticky Session Affinity.')
  affinity: 'none' | 'sticky'?
}

type TrafficWeight = {
  @description('Associates a traffic label with a revision.')
  label: string?

  @description('Indicates that the traffic weight belongs to a latest stable revision.')
  latestRevision: bool?

  @description('Name of a revision.')
  revisionName: string?

  @description('Traffic weight assigned to a revision.')
  weight: int?
}

type RegistryCredentials = {
  @description('A Managed Identity to use to authenticate with Azure Container Registry. For user-assigned identities, use the full user-assigned identity Resource ID. For system-assigned identities, use \'system\'.')
  identity: string?

  @description('The name of the Secret that contains the registry login password.')
  passwordSecretRef: string?

  @description('Container Registry Server.')
  server: string?

  @description('Container Registry Username.')
  username: string?
}

type Secret = {
  @description('Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.')
  identity: string?

  @description('Azure Key Vault URL pointing to the secret referenced by the container app.')
  keyVaultUrl: string?

  @description('Secret Name.')
  name: string?

  @description('Secret Value.')
  @secure()
  value: string?
}

type Service = {
  @description('Dev ContainerApp service type.')
  type: string
}

type Template = {
  @description('List of container definitions for the Container App.')
  containers: Container[]?

  @description('List of specialized containers that run before app containers.')
  initContainers: InitContainer[]?

  @description('User friendly suffix that is appended to the revision name.')
  revisionSuffix: string?

  @description('Scaling properties for the Container App.')
  scale: Scale?

  @description('List of container app services bound to the app.')
  serviceBinds: ServiceBind[]?

  @description('Optional duration in seconds the Container App Instance needs to terminate gracefully. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.')
  terminationGracePeriodSeconds: int?

  @description('List of volume definitions for the Container App.')
  volumes: Volume[]?
}

@export()
type Container = {
  @description('Container start command arguments.')
  args: string[]?

  @description('Container start command.')
  command: string[]?

  @description('Container environment variables.')
  env: EnvironmentVar[]?

  @description('Container image tag.')
  image: string?

  @description('Custom container name.')
  name: string?

  @description('List of probes for the container.')
  probes: ContainerAppProbe[]?

  @description('Container resource requirements.')
  resources: ContainerResources?

  @description('Container volume mounts.')
  volumeMounts: VolumeMount[]?
}

type EnvironmentVar = {
  @description('Environment variable name.')
  name: string?

  @description('Name of the Container App secret from which to pull the environment variable value.')
  secretRef: string?

  @description('Non-secret environment variable value.')
  value: string?
}

type ContainerAppProbe = {
  @description('Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. Maximum value is 10.')
  failureThreshold: int?

  @description('HTTPGet specifies the http request to perform.')
  httpGet: ContainerAppProbeHttpGet?

  @description('Number of seconds after the container has started before liveness probes are initiated. Minimum value is 1. Maximum value is 60.')
  initialDelaySeconds: int?

  @description('How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1. Maximum value is 240.')
  periodSeconds: int?

  @description('Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1. Maximum value is 10.')
  successThreshold: int?

  @description('TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported.')
  tcpSocket: ContainerAppProbeTcpSocket?

  @description('Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod\'s terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is an alpha field and requires enabling ProbeTerminationGracePeriod feature gate. Maximum value is 3600 seconds (1 hour).')
  terminationGracePeriodSeconds: int?

  @description('Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. Maximum value is 240.')
  timeoutSeconds: int?

  @description('The type of probe.')
  type: 'Liveness' | 'Readiness' | 'Startup'?
}

type ContainerAppProbeHttpGet = {
  @description('Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.')
  host: string?

  @description('Custom headers to set in the request. HTTP allows repeated headers.')
  httpHeaders: ContainerAppProbeHttpGetHttpHeadersItem[]?

  @description('Path to access on the HTTP server.')
  path: string?

  @description('Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.')
  port: int

  @description('Scheme to use for connecting to the host. Defaults to HTTP.')
  scheme: 'HTTP' | 'HTTPS'?
}

type ContainerAppProbeHttpGetHttpHeadersItem = {
  @description('The header field name.')
  name: string

  @description('The header field value.')
  value: string
}

type ContainerAppProbeTcpSocket = {
  @description('Optional: Host name to connect to, defaults to the pod IP.')
  host: string?

  @description('Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.')
  port: int
}

type ContainerResources = {
  @description('Required CPU in cores, e.g. 0.5 To specify a decimal value, use the json() function.')
  cpu: string?

  @description('Required memory, e.g. "250Mb".')
  memory: string?
}

type VolumeMount = {
  @description('Path within the container at which the volume should be mounted.Must not contain \':\'.')
  mountPath: string?

  @description('Path within the volume from which the container\'s volume should be mounted. Defaults to "" (volume\'s root).')
  subPath: string?

  @description('This must match the Name of a Volume.')
  volumeName: string?
}

type InitContainer = {
  @description('Container start command arguments.')
  args: string[]?

  @description('Container start command.')
  command: string[]?

  @description('Container environment variables.')
  env: EnvironmentVar[]?

  @description('Container image tag.')
  image: string?

  @description('Custom container name.')
  name: string?

  @description('Container resource requirements.')
  resources: ContainerResources?

  @description('Container volume mounts.')
  volumeMounts: VolumeMount[]?
}

type Scale = {
  @description('Optional. Maximum number of container replicas. Defaults to 10 if not set.')
  maxReplicas: int?

  @description('Optional. Minimum number of container replicas.')
  minReplicas: int?

  @description('Scaling rules.')
  rules: ScaleRule[]?
}

type ScaleRule = {
  @description('Azure Queue based scaling.')
  azureQueue: QueueScaleRule?

  @description('Custom scale rule.')
  custom: CustomScaleRule?

  @description('HTTP requests based scaling.')
  http: HttpScaleRule?

  @description('Scale Rule Name.')
  name: string?

  @description('Tcp requests based scaling.')
  tcp: TcpScaleRule?
}

type QueueScaleRule = {
  @description('Authentication secrets for the queue scale rule.')
  auth: ScaleRuleAuth[]?

  @description('Queue length.')
  queueLength: int?

  @description('Queue name.')
  queueName: string?
}

type ScaleRuleAuth = {
  @description('Name of the secret from which to pull the auth params.')
  secretRef: string?

  @description('Trigger Parameter that uses the secret.')
  triggerParameter: string?
}

type CustomScaleRule = {
  @description('Authentication secrets for the custom scale rule.')
  auth: ScaleRuleAuth[]?

  @description('Metadata properties to describe custom scale rule.')
  metadata: { *: string }?

  @description('Type of the custom scale rule eg: azure-servicebus, redis etc..')
  type: string?
}

type HttpScaleRule = {
  @description('Authentication secrets for the http scale rule.')
  auth: ScaleRuleAuth[]?

  @description('Metadata properties to describe http scale rule.')
  metadata: { *: string }?
}

type TcpScaleRule = {
  @description('Authentication secrets for the tcp scale rule.')
  auth: ScaleRuleAuth[]?

  @description('Metadata properties to describe tcp scale rule.')
  metadata: { *: string }?
}

type ServiceBind = {
  @description('serviceId.')
  name: string?

  @description('Resource id of the target service.')
  serviceId: string?
}

type Volume = {
  @description('Mount options used while mounting the AzureFile. Must be a comma-separated string.')
  mountOptions: string?

  @description('Volume name.')
  name: string?

  @description('List of secrets to be added in volume. If no secrets are provided, all secrets in collection will be added to volume.')
  secrets: SecretVolumeItem[]?

  @description('Name of storage resource. No need to provide for EmptyDir and Secret.')
  storageName: string?

  @description('Storage type for the volume. If not provided, use EmptyDir.')
  storageType: 'AzureFile' | 'EmptyDir' | 'Secret'?
}

type SecretVolumeItem = {
  @description('Path to project secret to. If no path is provided, path defaults to name of secret listed in secretRef.')
  path: string?

  @description('Name of the Container App secret from which to pull the secret value.')
  secretRef: string?
}
