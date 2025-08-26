import gleam/int
import gleam/list
import gleam/option

pub type TransitionModifier {
  Duration(ms: Int)
  Delay(Int)
  Opacity
  Scale(percentage: option.Option(Int), origin: List(ScaleOrigin))
}

pub type ScaleOrigin {
  Top
  Right
  Left
  Bottom
}

@internal
pub fn to_string(mod: TransitionModifier) {
  case mod {
    Delay(ms) -> ".delay." <> int.to_string(ms) <> "ms"
    Duration(ms) -> ".duration." <> int.to_string(ms) <> "ms"
    Opacity -> ".opacity"
    Scale(option.Some(percentage), origin) ->
      ".scale."
      <> int.to_string(percentage)
      <> list.fold(origin, "", fn(acc, origin) {
        acc <> scale_origin_to_string(origin)
      })
    Scale(option.None, origin) ->
      ".scale."
      <> list.fold(origin, "", fn(acc, origin) {
        acc <> scale_origin_to_string(origin)
      })
  }
}

@internal
pub fn scale_origin_to_string(origin: ScaleOrigin) {
  case origin {
    Bottom -> ".bottom"
    Left -> ".left"
    Right -> ".right"
    Top -> ".top"
  }
}
