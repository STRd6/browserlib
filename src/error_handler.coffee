###*
This error handler captures any runtime errors and reports them to the IDE
if present.
###
window.onerror = (message, url, lineNumber) ->
  # TODO: Display some context
  parent.displayRuntimeError?("#{message} on line #{lineNumber} of #{url}")

