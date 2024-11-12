@export()
func withManagedIdentity() object => {
  identity: {
    type: 'SystemAssigned'
  }
}
