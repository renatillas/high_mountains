# High Mountains 🏔️

[![Package Version](https://img.shields.io/hexpm/v/high_mountains)](https://hex.pm/packages/high_mountains)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/high_mountains/)

> A Gleam library for working with Alpine.js through Lustre attributes

High Mountains provides a type-safe, idiomatic Gleam wrapper for Alpine.js directives, allowing you to build interactive web applications using Alpine.js features within the Lustre ecosystem.

## Features

- **Complete Alpine.js coverage**: All Alpine.js directives are supported
- **Type safety**: Strongly typed modifiers and parameters prevent runtime errors
- **Lustre integration**: Seamlessly works with Lustre attributes
- **Modular design**: Import only what you need
- **Comprehensive modifiers**: Full support for event, model, and transition modifiers

## Installation

Add High Mountains to your Gleam project:

```sh
gleam add high_mountains
```

## Quick Start

```gleam
import lustre/element/html
import high_mountains as alpine

pub fn counter_component() {
  html.div([
    alpine.data("{count: 0}"),
    alpine.cloak()
  ], [
    html.button([
      alpine.on("click", [], "count++")
    ], [html.text("Increment")]),
    html.span([
      alpine.text("count")
    ], [])
  ])
}
```

## Core Directives

### Data Binding

- `data(js_object)` - Initialize Alpine component data
- `bind(attribute, js)` - Bind attributes to expressions
- `model(modifiers, js)` - Two-way data binding for inputs
- `text(js)` - Set text content
- `html(js)` - Set innerHTML

### Control Flow

- `x_if(js)` - Conditional rendering (use with `<template>`)
- `show(js)` - Toggle visibility
- `for(key, value)` - Loop through collections

### Events

- `on(event, modifiers, js)` - Handle DOM events with optional modifiers

### Effects and Lifecycle

- `init(js)` - Run code when component initializes
- `effect(js)` - Re-run when dependencies change

## Modifiers

### Event Modifiers

```gleam
import high_mountains/event_modifier.{Prevent, Stop, Debounce}
import gleam/option

html.form([
  alpine.on("submit", [Prevent], "submitForm()")
], [...])

html.input([
  alpine.on("input", [Debounce(option.Some(300))], "search()")
], [])
```

Available event modifiers:
- `Prevent` - preventDefault()
- `Stop` - stopPropagation()
- `Outside` - Listen for clicks outside element
- `Window` - Listen on window object
- `Document` - Listen on document
- `Once` - Listen only once
- `Debounce(ms)` - Debounce event handling
- `Throttle(ms)` - Throttle event handling
- `Self` - Only trigger if target is element itself
- `Camel` - Convert kebab-case to camelCase
- `Dot` - Allow periods in key names
- `Passive` - Add as passive listener
- `Capture` - Add in capture phase

### Model Modifiers

```gleam
import high_mountains/model_modifier.{Lazy, Number}

html.input([
  alpine.model([Lazy, Number], "price")
], [])
```

Available model modifiers:
- `Lazy` - Sync on change instead of input
- `Number` - Cast to number
- `Boolean` - Cast to boolean
- `Debounce(ms)` - Debounce model updates
- `Throttle(ms)` - Throttle model updates
- `Fill` - Auto-fill form data

### Transition Modifiers

```gleam
import high_mountains/transition_modifier.{Duration, Scale, Opacity}
import gleam/option

html.div([
  alpine.transition_helper([Duration(300), Scale(option.Some(95), []), Opacity])
], [...])
```

Available transition modifiers:
- `Duration(ms)` - Set transition duration
- `Delay(ms)` - Add transition delay  
- `Opacity` - Fade in/out
- `Scale(percentage, origins)` - Scale transitions with optional origins

## Advanced Features

### References

```gleam
html.input([alpine.ref("email")], [])
// Access with $refs.email in Alpine expressions
```

### Teleporting

```gleam
html.template([
  alpine.teleport("body")
], [
  // Modal content will be moved to body
])
```

### ID Scoping

```gleam
html.div([
  alpine.id("['tab-content', 'tab-trigger']")
], [
  // Use $id('tab-content') for unique IDs
])
```

### Preventing Initialization

```gleam
html.div([alpine.ignore()], [
  // Alpine won't initialize this section
])
```

### Preventing Flash

```gleam
html.div([alpine.cloak()], [
  // Hidden until Alpine loads
])
```

**CSS required for x-cloak:**
```css
[x-cloak] { display: none !important; }
```

## Examples

### Toggle Component

```gleam
import lustre/element/html
import high_mountains as alpine

pub fn toggle() {
  html.div([
    alpine.data("{open: false}")
  ], [
    html.button([
      alpine.on("click", [], "open = !open")
    ], [html.text("Toggle")]),
    
    html.div([
      alpine.show("open"),
      alpine.transition_helper([])
    ], [
      html.text("Content that toggles")
    ])
  ])
}
```

### Form with Validation

```gleam
import lustre/element/html
import high_mountains as alpine
import high_mountains/event_modifier

pub fn form() {
  html.form([
    alpine.data("{email: '', valid: false}"),
    alpine.on("submit", [event_modifier.Prevent], "submit()")
  ], [
    html.input([
      alpine.model([], "email"),
      alpine.on("input", [], "valid = email.includes('@')")
    ], []),
    
    html.button([
      alpine.bind("disabled", "!valid")
    ], [html.text("Submit")])
  ])
}
```

### Dynamic List

```gleam
import lustre/element/html
import high_mountains as alpine

pub fn todo_list() {
  html.div([
    alpine.data("{todos: [], newTodo: ''}")
  ], [
    html.input([
      alpine.model([], "newTodo"),
      alpine.on("keyup.enter", [], "todos.push(newTodo); newTodo = ''")
    ], []),
    
    html.template([
      alpine.for("todo", "todos")
    ], [
      html.div([
        alpine.key("todo")
      ], [
        html.span([alpine.text("todo")], [])
      ])
    ])
  ])
}
```

## API Reference

### Core Functions

All functions return Lustre attributes that can be used with HTML elements:

| Function | Alpine Directive | Description |
|----------|-----------------|-------------|
| `data(js_object)` | `x-data` | Initialize component data |
| `init(js)` | `x-init` | Run on initialization |
| `show(js)` | `x-show` | Toggle visibility |
| `show_important(js)` | `x-show.important` | Force visibility toggle |
| `bind(attr, js)` | `x-bind:attr` | Bind attribute to expression |
| `on(event, modifiers, js)` | `x-on:event` | Handle events |
| `text(js)` | `x-text` | Set text content |
| `html(js)` | `x-html` | Set innerHTML |
| `model(modifiers, js)` | `x-model` | Two-way data binding |
| `modelable(js)` | `x-modelable` | Make property modelable |
| `for(key, value)` | `x-for` | Loop through collections |
| `key(js)` | `:key` | Unique key for iterations |
| `x_if(js)` | `x-if` | Conditional rendering |
| `effect(js)` | `x-effect` | Watch dependencies |
| `ignore()` | `x-ignore` | Prevent Alpine initialization |
| `ref(id)` | `x-ref` | Element reference |
| `cloak()` | `x-cloak` | Hide until Alpine loads |
| `teleport(selector)` | `x-teleport` | Move element in DOM |
| `id(js)` | `x-id` | ID scoping |

### Transition Functions

| Function | Description |
|----------|-------------|
| `transition_helper(modifiers)` | Basic transition with modifiers |
| `transition_helper_enter(modifiers)` | Enter transition with modifiers |
| `transition_helper_leave(modifiers)` | Leave transition with modifiers |
| `transition_enter(classes)` | Enter phase classes |
| `transition_enter_start(classes)` | Enter start classes |
| `transition_end(classes)` | Enter end classes |
| `transition_leave(classes)` | Leave phase classes |
| `transition_leave_start(classes)` | Leave start classes |
| `transition_leave_end(classes)` | Leave end classes |

## Testing

```sh
gleam test
```

## Development

```sh
gleam build
gleam format
gleam docs build
```

## Contributing

1. Fork the repository on [GitHub](https://github.com/renatillas/high_mountains)
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Ensure code passes `gleam format` and `gleam test`
6. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Resources

- [Alpine.js Documentation](https://alpinejs.dev) - Official Alpine.js docs
- [Lustre Documentation](https://hexdocs.pm/lustre) - Lustre web framework
- [Gleam Language Guide](https://gleam.run) - Learn Gleam
- [Hex Documentation](https://hexdocs.pm/high_mountains) - API reference

---

Made with ❤️ for the Gleam and Alpine.js communities