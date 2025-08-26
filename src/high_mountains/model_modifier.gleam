import gleam/int
import gleam/option

pub type ModelModifier {
  Lazy
  Number
  Boolean
  Debounce(ms: option.Option(Int))
  Throttle(ms: option.Option(Int))
  Fill
}

@internal
pub fn to_string(mod: ModelModifier) {
  case mod {
    Lazy -> ".lazy"
    Number -> ".number"
    Boolean -> ".boolean"
    Debounce(option.None) -> ".debounce"
    Throttle(option.None) -> ".throttle"
    Debounce(option.Some(ms)) -> ".debounce." <> int.to_string(ms) <> "ms"
    Throttle(option.Some(ms)) -> ".throttle." <> int.to_string(ms) <> "ms"
    Fill -> ".fill"
  }
}
