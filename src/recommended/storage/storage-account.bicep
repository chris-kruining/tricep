import * as base from '../../base/storage/storage-account.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func storage_account(context Context, options Options) object =>
  base.storage_account(
    context,
    'Standard_LRS',
    'StorageV2',
    union(
      [
        with_access_tier('Hot')
      ],
      options
    )
  )

@export()
func with_public_access() object => base.with_allow_public_access(true)

@export()
func with_access_tier(accessTier base.AccessTier) object => base.with_access_tier(accessTier)
