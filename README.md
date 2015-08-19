# Stateless JavaScript utils

TL/DR: a toolbox with JavaScript sprinkles that I found handy during the years. They
should work great without attaching event handlers to elements on initialization,
since I like making apps that update the DOM with HTML from AJAX responses.

Utils:
- [element scroll listening](./onscroll)
- drag and drop (not implemented yet)
- file drag (not implemented yet)

## Reason for this toolbox

So I have made quite a few Rails apps over the last years, and I like Rails. And I like
"server rendered HTML" in opposition to client side MVC. Why? Usually because I
feel that we have to create two webapps instead of one when using client side MVC.
Two apps is usually more work and more code than one app.

So what is not uncommon in Rails is using Turbolinks or replacing parts of the
DOM with javascript-responses like

```js
$('.my-element').replaceWith('<%= j render @my_element %>');
```

Usually I really like this approach, because it gives a pretty good snappiness
(just as good as waiting for a JSON response from the server before rendering
anything). However with jQuery and JavaScript sprinkles, it is a _MUST_ to
write JavaScript and jQuery code in such a way that it handles all HTML in the
DOM at the time of execution, _AND_ in the future.

Look at the following code:
```js
$(function() {
  $('.my-element').click(function() {
    // do something
  });
});
```

This is problematic, because we attach event handlers to all elements matching `.my-element` on document load. This again is problematic for two reasons:

1. The browser has to do potentially much work before rendering something for the user (especially if the DOM is big) which again can be slow.
1. The event handlers are attached to each element in the DOM on document load, but new elements will not receive expected event listeners and behavior.

This typically means that you should change your code to something like this:

```js
$(document).on('click', '.my-element', function() {
  // do something
})
```

This approach I think is great. It is marginally more verbose, but you don't
have to wrap it in a `$(document).ready(function(){});` block, so the browser
there is actually not more code to write, while rendering in the browser will
probably be faster since the browser will not have to attach a bunch of event
handlers on document ready, and it will work for existing and new elements showing up in the DOM.

## The big problem with jQuery plugins

So the big problem with pretty much all jquery plugins I have seen it that they
are attached to elements when they are initialized and are therefore stateful.

For turbolinks you could come around this using something like
https://github.com/kossnocorp/jquery.turbolinks together with idempotent jQuery
plugins (which I have not tried), but this is usually not enough for me as I
tend to inject html into pages using custom JavaScript responses.

## The same problem with client side MVC

Many will probably disagree with me on this, but in the few client side MVC projects I have worked on, we have ended up having some really hard-to-solve problems with events being not being attached, or being attached more than once to elements in a template. This is usually really hard to debug.

I'm sure JavaScript frameworks are already better and will continue to improve solving these problems, but I cannot get away from thinking (and experiencing) that a fat client has a much bigger risk of falling out if sync with the servers state.

Hey, I'm probably wrong, but thats just how I feel about it.

## This should be a toolbox with little state

I want a toolbox for different JavaScript functionalities (yes, JavaScript sprinkles I guess) that I
come over, and I want that toolbox to be

- stateless if possible (dont attach event handlers to elements on page load)
- working for elements that might show up in the DOM later

## The code in this repo

The code will only be different JavaScript (or CoffeeScript) examples, and not
necessarily in the form of jQuery plugins or similar.

Said short, I plan to add anything here whenever I learn something new.
