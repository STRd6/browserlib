###*
A browser polyfill so you can consistently 
call requestAnimationFrame. Using 
requestAnimationFrame is preferred to 
setInterval for main game loops.

http://paulirish.com/2011/requestanimationframe-for-smart-animating/

@name requestAnimationFrame
@namespace
###

window.requestAnimationFrame ||= 
  window.webkitRequestAnimationFrame || 
  window.mozRequestAnimationFrame    || 
  window.oRequestAnimationFrame      || 
  window.msRequestAnimationFrame     || 
  (callback, element) ->
    window.setTimeout( ->
      callback(+new Date())
    , 1000 / 60)

