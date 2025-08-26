import gleam/int
import gleam/option

pub type EventModifier {
  Prevent
  Stop
  Outside
  Window
  Document
  Once
  Debounce(ms: option.Option(Int))
  Throttle(ms: option.Option(Int))
  Self
  Camel
  Dot
  Passive
  Capture
}

@internal
pub fn to_string(mod: EventModifier) {
  case mod {
    Prevent -> ".prevent"
    Stop -> ".stop"
    Outside -> ".outside"
    Window -> ".window"
    Document -> ".document"
    Once -> ".once"
    Debounce(option.None) -> ".debounce"
    Debounce(option.Some(ms)) -> ".debounce." <> int.to_string(ms) <> "ms"
    Throttle(option.None) -> ".throttle"
    Throttle(option.Some(ms)) -> ".throttle." <> int.to_string(ms) <> "ms"
    Self -> ".self"
    Camel -> ".camel"
    Dot -> ".dot"
    Passive -> ".passive"
    Capture -> ".capture"
  }
}
