targetScope = 'subscription'

param deployedAt string = utcNow('yyyyMMdd')
param environment string

module main './environment/main.bicep' = {
  name: 'main'
  params: {
    deployedAt: deployedAt
    environment: environment
  }
}
