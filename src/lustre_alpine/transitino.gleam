import gleam/option

pub type TransitionModifier {
  Duration(ms: Int)
  EnterDuration(ms: Int)
  LeaveDuration(ms: Int)
  Delay(Int)
  Opacity
  Scale(percentage: option.Option(Int), origin: List(ScaleOrigin))
  ScaleEnter(percentage: option.Option(Int))
  ScaleLeave(percentage: option.Option(Int))
}

pub type ScaleOrigin {
  Top
  Right
  Left
  Bottom
}
