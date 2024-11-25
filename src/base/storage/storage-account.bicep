import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func storage_account(context Context, sku Sku, kind Kind, options Options) object =>
  create_resource(
    context,
    'storageAccount',
    union(
      [
        {
          // name: nameShort('storageAccount', context)
          sku: {
            name: sku
          }
          kind: kind
        }
      ],
      options
    )
  )

// Sku
@export()
func with_sku(sku Sku) object => {
  sku: sku
}

@export()
type Sku =
  | 'Premium_LRS'
  | 'Premium_ZRS'
  | 'Standard_GRS'
  | 'Standard_GZRS'
  | 'Standard_LRS'
  | 'Standard_RAGRS'
  | 'Standard_RAGZRS'
  | 'Standard_ZRS'

// Kind
@export()
func with_kind(kind Kind) object => {
  kind: kind
}

@export()
type Kind = 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage' | 'Storage' | 'StorageV2'

// AccessTier
@export()
func with_access_tier(accessTier AccessTier) object => {
  properties: {
    accessTier: accessTier
  }
}

@export()
type AccessTier = 'Cool' | 'Hot' | 'Premium'

// AllowPublicAccess
@export()
func with_allow_public_access(allowPublicAccess bool) object => {
  properties: {
    allowPublicAccess: allowPublicAccess
  }
}
