$ ->
  ###*
  The global mouseDown property lets your query the status of mouse buttons.

  <code><pre>
  if mouseDown.left
    moveLeft()

  if mouseDown.right
    attack()
  </pre></code>

  @name mouseDown
  @namespace
  ###

  ###*
  The global mousePressed property lets your query the status of mouse buttons.
  However, unlike mouseDown it will only trigger the first time the button
  pressed.

  <code><pre>
  if mousePressed.left
    moveLeft()

  if mousePressed.right
    attack()
  </pre></code>

  @name mousePressed
  @namespace
  ###
  window.mouseDown = {}
  window.mousePressed = {}
  window.mousePosition = Point(0, 0)

  prevButtonsDown = {}

  buttonNames =
    1: "left"
    2: "middle"
    3: "right"

  buttonName = (event) ->
    buttonNames[event.which]

  $(document).bind "mousemove", (event) ->
    #TODO Position relative to canvas element
    mousePosition.x = event.pageX
    mousePosition.y = event.pageY

  $(document).bind "mousedown", (event) ->
    mouseDown[buttonName(event)] = true

  $(document).bind "mouseup", (event) ->
    mouseDown[buttonName(event)] = false

  window.updateMouse = ->
    window.mousePressed = {}

    for button, value of mouseDown
      mousePressed[button] = value unless prevButtonsDown[button]

    prevButtonsDown = {}
    for button, value of mouseDown
      prevButtonsDown[button] = value
