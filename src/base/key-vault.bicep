import { createResource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@description('key vault')
@export()
func keyVault(context Context, sku Sku, options Options) object =>
  createResource(
    context,
    'keyVault',
    union(
      [
        {
          properties: {
            sku: {
              name: 'A'
              family: sku
            }
            tenantId: context.tenant.tenantId
            enableRbacAuthorization: true
            enablePurgeProtection: true
            enableSoftDelete: true
          }
        }
      ],
      options
    )
  )

@export()
type Sku = 'premium' | 'standard'

// Soft delete
@export()
func withSoftDelete(enable bool) object => {
  properties: {
    enableSoftDelete: enable
  }
}
