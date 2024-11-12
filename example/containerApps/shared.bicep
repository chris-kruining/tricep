targetScope = 'subscription'

param deployedAt string = utcNow('yyyyMMdd')

module main './shared/main.bicep' = {
  name: 'main'
  params: {
    deployedAt: deployedAt
  }
}
