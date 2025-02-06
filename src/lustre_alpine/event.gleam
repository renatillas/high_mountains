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
