import * as common from '../base/storage-account.bicep'
import { Context, Options } from '../types.bicep'

@export()
func storageAccount(context Context, options Options) object =>
  common.storageAccount(
    context,
    'Standard_LRS',
    'StorageV2',
    union(
      [
        withAccessTier('Hot')
      ],
      options
    )
  )

@export()
func withPublicAccess() object => common.withAllowPublicAccess(true)

@export()
func withAccessTier(accessTier common.AccessTier) object => common.withAccessTier(accessTier)
