module "PixieCanvas"

test "exists", ->
  ok $.fn.pixieCanvas

test "#centerText font", ->
  canvas = $("<canvas>").pixieCanvas()
  
  fontString = "normal normal normal 11px/16px Monaco, monospace"
  
  canvas.centerText
    x: 50
    y: 50
    font: fontString
    
  equals canvas.font(), fontString

module()
