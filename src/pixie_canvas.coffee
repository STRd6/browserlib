( ($) ->
  $.fn.pixieCanvas = (options) ->
    options ||= {}

    canvas = this.get(0)
    context = undefined

    ###*
    PixieCanvas provides a convenient wrapper for working with Context2d.
    @name PixieCanvas
    @constructor
    ###
    $canvas = $(canvas).extend
      ###*
      Passes this canvas to the block with the given matrix transformation
      applied. All drawing methods called within the block will draw
      into the canvas with the transformation applied. The transformation
      is removed at the end of the block, even if the block throws an error.

      @name withTransform
      @methodOf PixieCanvas#

      @param {Matrix} matrix
      @param {Function} block
      @returns this
      ###
      withTransform: (matrix, block) ->
        context.save()

        context.transform(
          matrix.a,
          matrix.b,
          matrix.c,
          matrix.d,
          matrix.tx,
          matrix.ty
        )

        try
          block(@)
        finally
          context.restore()

        return @

      ###*
      @name clear
      @methodOf PixieCanvas#
      ###
      clear: ({x, y, width, height, bounds}={}) ->
        {x, y, width, height} = bounds if bounds

        context.clearRect(x, y, width, height)

        return @

      ###*
      @name fill
      @methodOf PixieCanvas

      @param {Number} x
      @param {Number} y
      @param {Number} width
      @param {Number} height
      @param {Bounds} [bounds]
      @param {String|Color} [color]
      ###
      fill: ({x, y, width, height, bounds, color}={}) ->
        {x, y, width, height} = bounds if bounds

        x ||= 0
        y ||= 0
        width = canvas.width unless width?
        height = canvas.height unless height?

        @fillColor(color)
        context.fillRect(x, y, width, height)

        return @

      context: ->
        context

      element: ->
        canvas

      ###*
      This is a gnarly function. Your best bet is to lett Drawable handle it. 

      @name drawImage
      @methodOf PixieCanvas#
      ###
      drawImage: (image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight) ->
        context.drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight)

        return @

      ###*
      Draws a circle at the specified position with the specified
      radius and color.

      @name drawCircle
      @methodOf PixieCanvas#

      @param {Number} x
      @param {Number} y
      @param {Point} [position]
      @param {Number} radius
      @param {Color|String} [color]
      @param {Circle} [circle]

      @returns this
      ###
      drawCircle: ({x, y, radius, position, color, stroke, circle}) ->
        {x, y} = position if position
        {x, y, radius} = circle if circle

        context.beginPath()
        context.arc(x, y, radius, 0, Math.TAU, true)
        context.closePath()

        @fillColor(color)
        context.fill()

        if stroke
          @strokeColor(stroke.color)
          @lineWidth(stroke.width)
          context.stroke()

        return @

      ###*
      Draws a rectangle at the specified position with given 
      width and height. Optionally takes a position, bounds
      and color argument. 

      @name drawRect
      @methodOf PixieCanvas#

      @param {Number} x
      @param {Number} y
      @param {Number} width
      @param {Number} height
      @param {Point} [position]
      @param {Color|String} [color]
      @param {Bounds} [bounds]
      @param {Stroke} [stroke]

      @returns this
      ###
      drawRect: ({x, y, width, height, position, bounds, color, stroke}) ->
        {x, y} = position if position
        {x, y, width, height} = bounds if bounds

        @fillColor(color)
        context.fillRect(x, y, width, height)

        if stroke
          @strokeColor(stroke.color)
          @lineWidth(stroke.width)
          context.strokeRect(x, y, width, height)

        return @

      ###*
      @name drawLine
      @methodOf PixieCanvas#

      @param {Point} start
      @param {Point} end
      @param {Number} [width]
      @param {String|Color} [color]
      ###
      drawLine: ({start, end, width, color}) ->
        width ||= 3

        @lineWidth(width)
        @strokeColor(color)

        context.beginPath()
        context.moveTo(start.x, start.y)
        context.lineTo(end.x, end.y)
        context.closePath()
        context.stroke()

        return @

      ###*
      @name fillPoly

      @returns this
      ###
      fillPoly: (points...) ->
        context.beginPath()
        points.each (point, i) ->
          if i == 0
            context.moveTo(point.x, point.y)
          else
            context.lineTo(point.x, point.y)
        context.lineTo points[0].x, points[0].y
        context.fill()

        return @

      ###*
      Adapted from http://js-bits.blogspot.com/2010/07/canvas-rounded-corner-rectangles.html
      ###
      drawRoundRect: ({x, y, width, height, radius, position, bounds, color, stroke}) ->
        radius ||= 5

        {x, y} = position if position
        {x, y, width, height} = bounds if bounds

        context.beginPath()
        context.moveTo(x + radius, y)
        context.lineTo(x + width - radius, y)
        context.quadraticCurveTo(x + width, y, x + width, y + radius)
        context.lineTo(x + width, y + height - radius)
        context.quadraticCurveTo(x + width, y + height, x + width - radius, y + height)
        context.lineTo(x + radius, y + height)
        context.quadraticCurveTo(x, y + height, x, y + height - radius)
        context.lineTo(x, y + radius)
        context.quadraticCurveTo(x, y, x + radius, y)
        context.closePath()

        if stroke
          @lineWidth(stroke.width)
          @strokeColor(stroke.color)
          context.stroke()

        context.fill()

        return @

      ###*
      @name fillText
      @methodOf PixieCanvas#
      ###
      fillText: ({x, y, text, position, color}) ->
        {x, y} = position if position

        @fillColor(color)
        context.fillText(text, x, y)

        return @

      centerText: ({text, y, position, color}) ->
        {y} = position if position

        textWidth = @measureText(text)

        @fillText {
          text
          color
          x: (canvas.width - textWidth) / 2
          y
        }

      fillWrappedText: ({text, x, y, width, position}) ->
        {x, y} = position if position

        tokens = text.split(" ")
        tokens2 = text.split(" ")
        lineHeight = 16

        if @measureText(text) > width
          if tokens.length % 2 == 0
            tokens2 = tokens.splice(tokens.length / 2, (tokens.length / 2), "")
          else
            tokens2 = tokens.splice(tokens.length / 2 + 1, (tokens.length / 2) + 1, "")

          context.fillText(tokens.join(" "), x, y)
          context.fillText(tokens2.join(" "), x, y + lineHeight)
        else
          context.fillText(tokens.join(" "), x, y + lineHeight)

      fillColor: (color) ->
        if color
          if color.channels
            context.fillStyle = color.toString()
          else
            context.fillStyle = color

          return this
        else
          return context.fillStyle

      strokeColor: (color) ->
        if color
          if color.channels
            context.strokeStyle = color.toString()
          else
            context.strokeStyle = color

          return this
        else
          return context.strokeStyle

      measureText: (text) ->
        context.measureText(text).width

      putImageData: (imageData, x, y) ->
        context.putImageData(imageData, x, y)

        return this

    contextAttrAccessor = (attrs...)->
      attrs.each (attr) ->
        $canvas[attr] = (newVal) ->
          if newVal?
            context[attr] = newVal
            return @
          else
            context[attr]

    contextAttrAccessor(
      "font",
      "globalAlpha",
      "globalCompositeOperation",
      "height",
      "lineWidth",
      "textAlign",
      "width",
    ) 

    if canvas?.getContext
      context = canvas.getContext('2d')

      if options.init
        options.init($canvas)

      return $canvas

)(jQuery)
