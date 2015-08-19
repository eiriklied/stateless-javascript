tooltipTemplate = """
<div class="tooltip in">
  <div class="tooltip-arrow"></div>
  <div class="tooltip-inner"></div>
</div>
"""
tooltipDistanceFromElement = 5

placementBasedOnOrientation = ($elem, $tooltip, orientation) ->
  elemPos = $elem.position()
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
    $elem.after($tooltip)
    $tooltip.css( placementBasedOnOrientation($elem, $tooltip, orientation) )

  $(document).on 'mouseleave', '[data-tooltip]', (e) ->
    $elem = $(this)
    # restore title
    $elem.attr('title', $elem.data('title')).data('title', null)
    $('.tooltip').remove()
