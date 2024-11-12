import { Context, Location, Tags } from './types.bicep'

@export()
func createContext(name string, template string, environment string, location Location, tags Tags) Context => {
  name: name
  template: template
  environment: environment
  location: location
  tags: tags
}
