import { create_resource } from '../../internal/resource.bicep'
import { Context, Options } from '../../types.bicep'

@export()
func app_configuration(context Context, sku Sku, options Options) object =>
  create_resource(
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
func with_sku(sku Sku) object => {
  sku: {
    name: sku
  }
}

@export()
type Sku = 'Free' | 'Standard'
