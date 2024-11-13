import { createResource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@export()
func storageAccount(context Context, sku Sku, kind Kind, options Options) object =>
  createResource(
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
func withSku(sku Sku) object => {
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
func withKind(kind Kind) object => {
  kind: kind
}

@export()
type Kind = 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage' | 'Storage' | 'StorageV2'

// AccessTier
@export()
func withAccessTier(accessTier AccessTier) object => {
  properties: {
    accessTier: accessTier
  }
}

@export()
type AccessTier = 'Cool' | 'Hot' | 'Premium'

// AllowPublicAccess
@export()
func withAllowPublicAccess(allowPublicAccess bool) object => {
  properties: {
    allowPublicAccess: allowPublicAccess
  }
}
