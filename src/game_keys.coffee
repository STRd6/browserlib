(->
root = (exports ? this)

root.gameKeys = (keyMap) ->
  parent.postMessage {type: 'controls', data: keyMap}, 'http://pixieengine.com'
)()