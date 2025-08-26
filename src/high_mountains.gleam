import gleam/list
import high_mountains/event_modifier.{type EventModifier}
import high_mountains/model_modifier.{type ModelModifier}
import high_mountains/transition_modifier.{type TransitionModifier}
import lustre/attribute.{attribute}

/// Everything in Alpine starts with the x-data directive.
///
/// x-data defines a chunk of HTML as an Alpine component and provides the reactive data for that component to reference.
pub fn data(js_object: String) {
  attribute("x-data", js_object)
}

/// The x-init directive allows you to hook into the initialization phase of any element in Alpine.
pub fn init(js: String) {
  attribute("x-init", js)
}

/// x-show is one of the most useful and powerful directives in Alpine. It provides an expressive way to show and hide DOM elements.
///
/// If the "default" state of an x-show on page load is "false", you may want to use x-cloak on the page to avoid "page flicker" (The effect that happens when the browser renders your content before Alpine is finished initializing and hiding it.) You can learn more about x-cloak in its documentation.
pub fn show(js: String) {
  attribute("x-show", js)
}

/// Sometimes you need to apply a little more force to actually hide an element. In cases where a CSS selector applies the display property with the !important flag, it will take precedence over the inline style set by Alpine.
pub fn show_important(js: String) {
  attribute("x-show.important", js)
}

/// x-bind allows you to set HTML attributes on elements based on the result of JavaScript expressions.
pub fn bind(attribute attr: String, js js: String) {
  attribute("x-bind:" <> attr, js)
}

/// x-on allows you to easily run code on dispatched DOM events.
pub fn on(event: String, modifiers: List(EventModifier), js: String) {
  let modifiers =
    list.fold(modifiers, "", fn(acc, modifier) {
      acc <> event_modifier.to_string(modifier)
    })
  attribute("x-on:" <> event <> modifiers, js)
}

/// x-text sets the text content of an element to the result of a given expression.
pub fn text(js: String) {
  attribute("x-text", js)
}

/// x-html sets the "innerHTML" property of an element to the result of a given expression
pub fn html(js: String) {
  attribute("x-html", js)
}

/// x-model allows you to bind the value of an input element to Alpine data.
///
/// x-model is two-way bound, meaning it both "sets" and "gets". In addition to changing data, if the data itself changes, the element will reflect the change.
///
/// x-model works with the following input elements:
///
/// - input type="text"
/// - textarea
/// - input type="checkbox"
/// - input type="radio"
/// - select
/// - input type="range"
pub fn model(modifiers: List(ModelModifier), js: String) {
  let modifiers =
    list.fold(modifiers, "", fn(acc, modifier) {
      acc <> model_modifier.to_string(modifier)
    })
  attribute("x-model" <> modifiers, js)
}

/// x-modelable allows you to expose any Alpine property as the target of the x-model directive.
pub fn modelable(js: String) {
  attribute("x-modelable", js)
}

/// x-for directive allows you to create DOM elements by iterating through a list
pub fn for(key: String, value: String) {
  attribute("x-for", key <> " in " <> value)
}

/// It is important to specify unique keys for each x-for iteration if you are going to be re-ordering items. Without dynamic keys, Alpine may have a hard time keeping track of what re-orders and will cause odd side-effects.
pub fn key(js: String) {
  attribute(":key", js)
}

/// Alpine provides a robust transitions utility out of the box. With a few x-transition directives, you can create smooth transitions between when an element is shown or hidden.
///
/// Initially, the duration is set to be 150 milliseconds when entering, and 75 milliseconds when leaving.
pub fn transition_helper(modifiers: List(TransitionModifier)) {
  let modifiers =
    list.fold(modifiers, "", fn(acc, modifier) {
      acc <> transition_modifier.to_string(modifier)
    })
  attribute("x-transition" <> modifiers, "")
}

pub fn transition_helper_enter(modifiers: List(TransitionModifier)) {
  let modifiers =
    list.fold(modifiers, "", fn(acc, modifier) {
      acc <> transition_modifier.to_string(modifier)
    })
  attribute("x-transition:enter" <> modifiers, "")
}

pub fn transition_helper_leave(modifiers: List(TransitionModifier)) {
  let modifiers =
    list.fold(modifiers, "", fn(acc, modifier) {
      acc <> transition_modifier.to_string(modifier)
    })
  attribute("x-transition:leave" <> modifiers, "")
}

/// Applied during the entire entering phase.
pub fn transition_enter(css_classes: String) {
  attribute("x-transition:enter", css_classes)
}

/// Added before element is inserted, removed one frame after element is inserted.
pub fn transition_enter_start(css_classes: String) {
  attribute("x-transition:enter-start", css_classes)
}

/// Added one frame after element is inserted (at the same time enter-start is removed), removed when transition/animation finishes.
pub fn transition_end(css_classes: String) {
  attribute("x-transition:enter-end", css_classes)
}

/// Applied during the entire leaving phase.
pub fn transition_leave(css_classes: String) {
  attribute("x-transition:leave", css_classes)
}

/// Added immediately when a leaving transition is triggered, removed after one frame.
pub fn transition_leave_start(css_classes: String) {
  attribute("x-transition:leave-start", css_classes)
}

/// Added one frame after a leaving transition is triggered (at the same time leave-start is removed), removed when the transition/animation finishes.
pub fn transition_leave_end(css_classes: String) {
  attribute("x-transition:leave-end", css_classes)
}

/// x-effect is a useful directive for re-evaluating an expression when one of its dependencies change. You can think of it as a watcher where you don't have to specify what property to watch, it will watch all properties used within it.
pub fn effect(js: String) {
  attribute("x-effect", js)
}

/// By default, Alpine will crawl and initialize the entire DOM tree of an element containing x-init or x-data.
///
/// If for some reason, you don't want Alpine to touch a specific section of your HTML, you can prevent it from doing so using x-ignore.
pub fn ignore() {
  attribute("x-ignore", "")
}

/// x-ref allows you to reference an element in your Alpine component by a unique name.
pub fn ref(id: String) {
  attribute("x-ref", id)
}

/// Sometimes, when you're using AlpineJS for a part of your template, there is a "blip" where you might see your uninitialized template after the page loads, but before Alpine loads.
///
/// x-cloak addresses this scenario by hiding the element it's attached to until Alpine is fully loaded on the page.
///
/// For x-cloak to work however, you must add the following CSS to the page.
/// ```css
/// [x-cloak] { display: none !important; }
/// ```
pub fn cloak() {
  attribute("x-cloak", "")
}

/// The x-teleport directive allows you to transport part of your Alpine template to another part of the DOM on the page entirely.
///
/// This is useful for things like modals (especially nesting them), where it's helpful to break out of the z-index of the current Alpine component.
///
/// By attaching x-teleport to a <template> element, you are telling Alpine to "append" that element to the provided selector.
pub fn teleport(css_selector: String) {
  attribute("x-teleport", css_selector)
}

/// x-if is used for toggling elements on the page, similarly to x-show, however it completely adds and removes the element it's applied to rather than just changing its CSS display property to "none".
///
///Because of this difference in behavior, x-if should not be applied directly to the element, but instead to a <template> tag that encloses the element. This way, Alpine can keep a record of the element once it's removed from the page.
pub fn x_if(js: String) {
  attribute("x-if", js)
}

/// x-id allows you to declare a new "scope" for any new IDs generated using $id(). It accepts an array of strings (ID names) and adds a suffix to each $id('...') generated within it that is unique to other IDs on the page.
///
///x-id is meant to be used in conjunction with the $id(...) magic.
pub fn id(js: String) {
  attribute("x-id", js)
}
