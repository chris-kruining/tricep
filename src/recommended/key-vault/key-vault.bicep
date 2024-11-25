import * as base from '../../base/key-vault/key-vault.bicep'
import { Context, Options } from '../../types.bicep'

@description('Key vault')
@export()
func key_vault(context Context, options Options) object => base.key_vault(context, 'standard', options)

// Sku
@export()
func with_premium_sku() object => {
  properties: {
    sku: {
      family: 'premium'
    }
  }
}

// Soft delete
@export()
func with_soft_delete(context Context, enable bool) object => base.with_soft_delete(enable)
