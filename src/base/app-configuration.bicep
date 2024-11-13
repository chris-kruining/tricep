import { createResource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@export()
func appConfiguration(context Context, sku Sku, options Options) object =>
  createResource(
    context,
    'appConfiguration',
    union(
      [
        {
          sku: {
            name: sku
          }
        }
      ],
      options
    )
  )

// Sku
@export()
func withSku(sku Sku) object => {
  sku: {
    name: sku
  }
}

@export()
type Sku = 'Free' | 'Standard'
