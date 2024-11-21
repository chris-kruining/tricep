import * as base from '../base/static-web-app.bicep'
import { Context, Options } from '../types.bicep'

@export()
func static_web_app(context Context, options Options) object =>
  base.static_web_app(
    context,
    union(
      [
        {
          properties: {}
        }
      ],
      options
    )
  )

@export()
func with_managed_identity() object => base.with_identity('SystemAssigned')

@export()
func withDefaultSku() object => base.with_sku('Standard')
