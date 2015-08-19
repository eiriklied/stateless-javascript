# Display simple tooltips. Now and in the future

## Short usage

```js
// initialize anywhere after you loaded the stateless-tooltips.js
stateless.tooltip();
```
After this, any element with the `data-tooltip` attribute will display a
the value of the `data-tooltip` attribute when hovering over:

```html
<img src="..." data-tooltip="My handy tooltip" data-position="top|right|bottom|left"/>
```

Now any element (both existing and those that might show up with AJAX) will get
handy tooltips, assuming Twitter Bootstrap styling.

## Why not Bootstraps JS?

The difference is that with their JavaScript, you have to
[initialize the plugin](http://getbootstrap.com/javascript/#tooltips)
using a selector on page load:

```js
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
```

This effectively means that new elements showing up in the DOM will not work
even though the element have the same `data-` element as in the JS example
above. This is because Bootstrap will only attach its event handlers when the
jQuery selector is run on document load so changes to the DOM can give weird
results.
