registeredSelectors = {}

_onScroll = (e) ->
  # start = performance.now()
  # for selector, callback of registeredSelectors
  #   $(e.target).is(selector)
  # console.log("#{performance.now() - start} ms")

  for selector, callback of registeredSelectors
    if $(e.target).is(selector)
      callback(e)

window.addEventListener('scroll', _onScroll, true)

# only exposed API
window.onElementScroll = (selector, callback) ->
  registeredSelectors[selector] = callback
