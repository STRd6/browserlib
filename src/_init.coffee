# Prevent browser contextmenu from popping up in games.
document.oncontextmenu = -> false

# Prevent default keypresses except for input fields
$(document).bind "keydown", (event) ->
  event.preventDefault() unless $(event.target).is "input"
