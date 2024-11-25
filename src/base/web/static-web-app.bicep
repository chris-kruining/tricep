import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func static_web_app(context Context, options Options) object => create_resource(context, 'staticWebApp', options)

// Identity
@export()
func with_identity(identity Identity) object => {
  identity: {
    type: identity
  }
}

@export()
type Identity = 'SystemAssigned' | 'Manual'

// Sku
@export()
func with_sku(sku Sku) object => {
  sku: {
    name: sku
    tier: sku
  }
}

@export()
type Sku = 'Standard'
