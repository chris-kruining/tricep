import * as base from '../../base/web/static-web-app.bicep'
import { Context, Options } from '../../types.bicep'

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
func with_default_sku() object => base.with_sku('Standard')
