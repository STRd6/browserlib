Gamepads.CombinedController = (sources...) ->

  self = Core().extend
    buttonDown: (buttons...) ->
      sources.inject false, (memo, source) ->
        memo or source.buttonDown buttons...

    # true if button was just pressed
    buttonPressed: (button) ->
      sources.inject false, (memo, source) ->
        memo or source.buttonPressed(button)

    # true if button was just released
    buttonReleased: (button) ->
      sources.inject false, (memo, source) ->
        memo or source.buttonPressed(button)

    position: (stick=0) ->
      raw = sources.inject Point(0, 0), (point, source) ->
        point.add(source.position(stick))

      # TODO: This could be a point method
      if raw.length() > 1
        raw.norm()
      else
        raw

    tap: ->
      raw = sources.inject Point(0, 0), (point, source) ->
        point.add(source.tap())

      Point(raw.x.sign(), raw.y.sign())

    update: ->
      sources.invoke "update"

    drawDebug: (canvas) ->
      sources.invoke "drawDebug", canvas
