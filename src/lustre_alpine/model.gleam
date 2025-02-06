import gleam/option

pub type ModelModifier {
  Lazy
  Number
  Boolean
  Debounce(ms: option.Option(Int))
  Throttle(ms: option.Option(Int))
  Fill
}
