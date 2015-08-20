# not all browsers have requestAnimationFrame, so we will not try to throttle
# unless they do
if window.requestAnimationFrame
  throttle = (type, name, _obj) ->
    obj = _obj || window
    running = false
    func = ->
      if running
        return
      running = true
      requestAnimationFrame ->
        obj.dispatchEvent(new CustomEvent(name))
        running = false;
    obj.addEventListener(type, func, true) # true for event capturing, not bubbling

  throttle('scroll', 'optimizedScroll', window);


tooltipTemplate = """
<div class="tooltip in">
  <div class="tooltip-arrow"></div>
  <div class="tooltip-inner"></div>
</div>
"""
tooltipDistanceFromElement = 5

placementBasedOnOrientation = ($elem, $tooltip, orientation) ->
  elemPos = $elem.offset()
  switch orientation
    when 'left'
      top: elemPos.top + $elem[0].offsetHeight/2 - $tooltip[0].offsetHeight/2
      left: elemPos.left - $tooltip[0].offsetWidth - tooltipDistanceFromElement
    when 'right'
      top: elemPos.top + $elem[0].offsetHeight/2 - $tooltip[0].offsetHeight/2
      left: elemPos.left + $elem[0].offsetWidth + tooltipDistanceFromElement
    when 'top'
      top: elemPos.top - $tooltip[0].offsetHeight - tooltipDistanceFromElement
      left: elemPos.left - $tooltip[0].offsetWidth/2 + $elem[0].offsetWidth/2
    when 'bottom'
      top: elemPos.top + $elem[0].offsetHeight + tooltipDistanceFromElement
      left: elemPos.left - $tooltip[0].offsetWidth/2 + $elem[0].offsetWidth/2


window.stateless = window.stateless || {}

window.stateless.tooltip = ->
  $(document).on 'mouseenter', '[data-tooltip]', (e) ->
    $elem = $(this)
    orientation = $elem.data('placement') || 'top'
    # remove title to avoid both tooltips and title
    $elem.data('title', $elem.attr('title')).attr('title', null)
    text = $(this).data 'tooltip'

    $tooltip = $(tooltipTemplate).addClass(orientation)
    $tooltip.find('.tooltip-inner').text(text)
    #$elem.after($tooltip)
    $('body').append($tooltip)
    $tooltip.css( placementBasedOnOrientation($elem, $tooltip, orientation) )

  $(document).on 'mouseleave', '[data-tooltip]', (e) ->
    $elem = $(this)
    # restore title
    $elem.attr('title', $elem.data('title')).data('title', null)
    $('.tooltip').remove()

  # listen to all scrolling, both on document and in sub elements
  # and disable tooltip if it is up because it would otherwise
  # move with scrolling and look ugly
  window.addEventListener('optimizedScroll', ->
    # known bug, we do not restore titles on elements here. like on mouseleave.
    $('.tooltip').remove()
  , true)
