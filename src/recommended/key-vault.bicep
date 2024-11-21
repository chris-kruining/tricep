import * as base from '../base/key-vault.bicep'
import { Context, Options } from '../types.bicep'

@description('Key vault')
@export()
func keyVault(context Context, options Options) object => base.keyVault(context, 'standard', options)

// Sku
@export()
func withPremiumSku() object => {
  properties: {
    sku: {
      family: 'premium'
    }
  }
}

// Soft delete
@export()
func withSoftDelete(context Context, enable bool) object => base.withSoftDelete(enable)
