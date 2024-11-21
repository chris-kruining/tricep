@export()
func with_managed_identity() object => {
  identity: {
    type: 'SystemAssigned'
  }
}
