import { Context, Options } from '../../types.bicep'
import { create_resource } from '../../internal/resource.bicep'

@export()
func container_registry(context Context, sku Sku, options Options) object =>
  create_resource(
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
func with_sku(sku Sku) object => {
  sku: {
    name: sku
  }
}

@export()
type Sku = 'Basic' | 'Classic' | 'Premium' | 'Standard'
