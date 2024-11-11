@export()
type Context = {
  template: string
  environment: string
  location: string
}

@export()
type Tags = {
  *: string
}

@export()
type _Resource = {
  // TODO :: waiting till some kind of type extension/inheritance/merging is done
  // https://github.com/Azure/bicep/issues/14135
}
