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
