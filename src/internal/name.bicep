@export()
func createName(context object, template string) string =>
  reduce(items(context), template, (t, e) => replace(string(t), '$${e.key}', e.value))
