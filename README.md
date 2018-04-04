# purescript-concur-semantic

## What is it
[Semantic UI](https://semantic-ui.com/) bindings for [Concur](https://github.com/ajnsit/purescript-concur).

**It's also a good demonstration of using external React components with Concur.**

## Example Usage
1. Include semantic-ui CSS in your html page. In the examples I load them from a CDN like so -

```html
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.1/dist/semantic.min.css">
```

2. Use one of the widgets supplied by this library. E.g. -

```purescript
import Concur.SemanticUI.Button (displayButton)
import Concur.SemanticUI.Button as B

helloWidget :: forall a. Widget HTML a
helloWidget = do
  displayButton (B.primary := true) (text "Click me")
  displayButton (B.secondary := true <> B.size := Massive) (text "Hello Sailor!")
  helloWidget
```

### [Demo of the result](https://ajnsit.github.io/purescript-concur-semantic/).


## Attribution
Borrows parts of the semi-automatic binding generation code from https://github.com/albertov/purescript-react-semantic-ui/blob/master/gen.sh (MIT license).
