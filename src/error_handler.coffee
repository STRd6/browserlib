###*
This error handler captures any runtime errors and reports them to the IDE
if present.
###
window.onerror = (message) ->
  parent.displayRuntimeError?(message)

