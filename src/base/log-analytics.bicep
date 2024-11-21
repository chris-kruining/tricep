import { create_resource } from '../internal/resource.bicep'
import { Context, Options } from '../types.bicep'

@export()
func log_analytics(context Context, sku Sku, options Options) object =>
  create_resource(
    context,
    'logAnalytics',
    union(
      [
        {
          properties: {
            sku: {
              name: sku
            }
          }
        }
      ],
      options
    )
  )

@export()
type Sku = 'PerGB2018'
