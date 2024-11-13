import { createResource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@export()
func staticWebApp(context Context, options Options) object => createResource(context, 'staticWebApp', options)

// Identity
@export()
func withIdentity(identity Identity) object => {
  identity: {
    type: identity
  }
}

@export()
type Identity = 'SystemAssigned' | 'Manual'

// Sku
@export()
func withSku(sku Sku) object => {
  sku: {
    name: sku
    tier: sku
  }
}

@export()
type Sku = 'Standard'
