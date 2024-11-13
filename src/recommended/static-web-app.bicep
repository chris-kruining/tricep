import * as base from '../base/static-web-app.bicep'
import { Context, Options } from '../types.bicep'

@export()
func staticWebApp(context Context, options Options) object =>
  base.staticWebApp(
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
func withManagedIdentity() object => base.withIdentity('SystemAssigned')

@export()
func withDefaultSku() object => base.withSku('Standard')
