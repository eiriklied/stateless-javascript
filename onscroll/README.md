# Listen to element scrolling. Now and in the future

## Short usage

```js
stateless.onScroll('.scroller-box', function(e){
  console.log('.scroller-box was scrolled!');
});
```

Tested Aug 2015 on a Mac with:

- Chrome
- Firefox
- Safari

## The problem we are solving

Say you have an element
```html
<div class="scroller-box">Content</div>
```
with styling
```css
.scroller-box {
  height: 100px;
  overflow: scroll;
}
```

With jQuery you can listen to an element scrolling like this:

```js
$(document).ready(function() {
  $('.scroller-box').on('scroll', function() {
    // do something one scroll. For example load more content
  });
});
```

The scroll event will not bubble like clicks do, so we cannot use good old
`$(document).on()`.
```js
// This will not work
$(document).on('scroll', '.scroller-box', function() {
  // Wont be triggered
});
```

So what to do?

## Capturing instead of bubbling

I didn't know this existed before starting to look for a solution, but there is
both a [capture phase and a bubble phase](http://www.quirksmode.org/js/events_order.html) for events.

And it seems we can capture scroll events before going down to the element so we
can listen to scroll events even though the scroll event is not bubbling back
up to the document.
