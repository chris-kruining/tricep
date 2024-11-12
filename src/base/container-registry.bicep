import { Context, Options } from '../types.bicep'
import { createResource } from '../internal/resource.bicep'

@export()
func containerRegistry(context Context, sku Sku, options Options) object =>
  createResource(
    context,
    'containerRegistry',
    concat(
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

@export()
type Sku = 'Basic' | 'Classic' | 'Premium' | 'Standard'
