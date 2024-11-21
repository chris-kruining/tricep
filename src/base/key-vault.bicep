import { create_resource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@description('key vault')
@export()
func key_vault(context Context, sku Sku, options Options) object =>
  create_resource(
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
func with_soft_delete(enable bool) object => {
  properties: {
    enableSoftDelete: enable
  }
}
