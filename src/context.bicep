import { Context } from './types.bicep'

@export()
func createContext(template string, environment string, location string) Context => {
  template: template
  environment: environment
  location: location
}
