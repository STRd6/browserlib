$ ->
  ###*
  The global keydown property lets your query the status of keys.

  <code><pre>
  if keydown.left
    moveLeft()

  if keydown.a or keydown.space
    attack()

  if keydown.return
    confirm()

  if keydown.esc
    cancel()
  </pre></code>

  @name keydown
  @namespace
  ###

  ###*
  The global justPressed property lets your query the status of keys. However, 
  unlike keydown it will only trigger once for each time the key is pressed.

  <code><pre>
  if justPressed.left
    moveLeft()

  if justPressed.a or justPressed.space
    attack()

  if justPressed.return
    confirm()

  if justPressed.esc
    cancel()
  </pre></code>

  @name justPressed
  @namespace
  ###
  window.keydown = {}
  window.justPressed = {}

  prevKeysDown = {}

  keyName = (event) ->
    jQuery.hotkeys.specialKeys[event.which] ||
    String.fromCharCode(event.which).toLowerCase()

  $(document).bind "keydown", (event) ->
    key = keyName(event)
    keydown[key] = true

  $(document).bind "keyup", (event) ->
    key = keyName(event)
    keydown[key] = false

  window.updateKeys = () ->
    window.justPressed = {}
    keydown.any = false

    for key, value of keydown
      justPressed[key] = value unless prevKeysDown[key]

      justPressed.any = true if (justPressed[key] || mousePressed.left || mousePressed.right)
      keydown.any = true if (value || mouseDown.left || mouseDown.right)

    prevKeysDown = {}
    for key, value of keydown
      prevKeysDown[key] = value
