###
  PositionCorners figures out where to put the little corner divs at the edges
  of the canvas. Three of the four corners are just for appearance. Clicking
  on the lower right one will actually resize the canvas.

  Currently I am debating whether its worth having these at all.
  They act more like needless decoration than actual visual ques.

  Would a use not actually know they can resize without them?
  After all, arent modern computer users familiar with clicking 
  dragging? Dont they have a sense of that capacity?
###
positionCorners = ->
  if cornersVisible
    $('#corner0Div').css('top',(canvasYPos-1+canvasYOffset).toString())
    $('#corner0Div').css('left',(canvasXPos-1+canvasXOffset).toString())

    $('#corner1Div').css('top',(canvasYPos-1+canvasYOffset).toString())
    $('#corner1Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#corner2Div').css('top',(canvasYPos+canvasHeight+1+canvasYOffset).toString())
    $('#corner2Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#corner3Div').css('top',(canvasYPos+canvasHeight+1+canvasYOffset).toString())
    $('#corner3Div').css('left',(canvasXPos-1+canvasXOffset).toString())
  
  else
    $('#corner0Div').css('top',(window.innerHeight).toString())
    $('#corner0Div').css('left',(canvasXPos-1+canvasXOffset).toString())

    $('#corner1Div').css('top',(window.innerHeight).toString())
    $('#corner1Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#corner2Div').css('top',(window.innerHeight).toString())
    $('#corner2Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#corner3Div').css('top',(window.innerHeight).toString())
    $('#corner3Div').css('left',(canvasXPos-1+canvasXOffset).toString())  

###
  Figure out where to put the canvas
###
positionCanvas = ->
  $('#ctpaintDiv').css('top', (canvasYPos+canvasYOffset).toString())
  $('#ctpaintDiv').css('left',(canvasXPos+canvasXOffset).toString())

###
  Only done at the very initialization of CtPaint.
###
prepareCanvas = ->
  ctContext.canvas.width = canvasWidth
  ctContext.canvas.height = canvasHeight

  ctContext.fillStyle = '#000000'
  ctContext.fillRect(0,0,canvasWidth,canvasHeight)

  positionCanvas()
  positionCorners()

###
  Position the menu div. The menu is un-(de?)-initialized
  by just putting the menu off screen and switching tools
  (ending the menus functionality)
###
positionMenu = () ->
  if not menuUp
    $('#menuDiv').css('top',(window.innerHeight).toString())

setCanvasSizes = ->
  toolbar0Context.canvas.width = toolbarWidth
  toolbar0Context.canvas.height = window.innerHeight-toolbarHeight

  toolbar1Context.canvas.width = window.innerWidth
  toolbar1Context.canvas.height = toolbarHeight

  backgroundContext.canvas.width = window.innerWidth
  backgroundContext.canvas.height = window.innerHeight

placeToolbars = ->
  $('#toolbar0Div').css('top', '0')
  $('#toolbar1Div').css('top', (window.innerHeight-toolbarHeight).toString())

drawToolbars = ->
  toolbar0Context.fillStyle = '#202020'
  toolbar0Context.fillRect(0,0,toolbarWidth,window.innerHeight-toolbarHeight)
  toolbar0Context.drawImage(toolbar0sImages[toolViewMode],0,0)
  drawLine(toolbar0Context,[16,20,8],toolbarWidth-1,0,toolbarWidth-1,window.innerHeight-toolbarHeight)
  toolbar0Context.drawImage(
    tH[tH.length - 1].pressedImage[toolViewMode]
    tH[tH.length - 1].clickRegion[0],
    tH[tH.length - 1].clickRegion[1])

  if toolViewMode is 0

    if tH[tH.length - 1].name is 'square'
      if not tH[tH.length - 1].mode
        theImage = fancyResponsiveIcons['square'][1][tH[tH.length - 1].magnitude - 1]
        iconX = tH[tH.length - 1].clickRegion[0]
        iconY = tH[tH.length - 1].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)
      else
        theImage = solidIcons['square'][1]
        iconX = tH[tH.length - 1].clickRegion[0]
        iconY = tH[tH.length - 1].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)
    else
      if not ctPaintTools[toolsToNumbers['square']].mode
        if ctPaintTools[toolsToNumbers['square']].magnitude > 1
          theImage = 
            fancyResponsiveIcons['square'][0][ctPaintTools[toolsToNumbers['square']].magnitude - 1]
          iconX = ctPaintTools[toolsToNumbers['square']].clickRegion[0]
          iconY = ctPaintTools[toolsToNumbers['square']].clickRegion[1]
          toolbar0Context.drawImage( theImage, iconX, iconY)
      else
        theImage = solidIcons['square'][0]
        iconX = ctPaintTools[toolsToNumbers['square']].clickRegion[0]
        iconY = ctPaintTools[toolsToNumbers['square']].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)

    if tH[tH.length - 1].name is 'circle'
      if not tH[tH.length - 1].mode
        theImage = fancyResponsiveIcons['circle'][1][tH[tH.length - 1].magnitude - 1]
        iconX = tH[tH.length - 1].clickRegion[0]
        iconY = tH[tH.length - 1].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY )
      else
        theImage = solidIcons['circle'][1]
        iconX = tH[tH.length - 1].clickRegion[0]
        iconY = tH[tH.length - 1].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)
    else
      if not ctPaintTools[toolsToNumbers['circle']].mode
        if ctPaintTools[toolsToNumbers['circle']].magnitude > 1
          theImage = 
            fancyResponsiveIcons['circle'][0][ctPaintTools[toolsToNumbers['circle']].magnitude - 1]
          iconX = ctPaintTools[toolsToNumbers['circle']].clickRegion[0]
          iconY = ctPaintTools[toolsToNumbers['circle']].clickRegion[1]
          toolbar0Context.drawImage( theImage, iconX, iconY)
      else
        theImage = solidIcons['circle'][0]
        iconX = ctPaintTools[toolsToNumbers['circle']].clickRegion[0]
        iconY = ctPaintTools[toolsToNumbers['circle']].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)

    if tH[tH.length - 1].name is 'line'
      theImage = fancyResponsiveIcons['line'][1][tH[tH.length - 1].magnitude - 1]
      iconX = tH[tH.length - 1].clickRegion[0]
      iconY = tH[tH.length - 1].clickRegion[1]
      toolbar0Context.drawImage( theImage, iconX, iconY )
    else
      if ctPaintTools[toolsToNumbers['line']].magnitude > 1
        theImage = 
          fancyResponsiveIcons['line'][0][ctPaintTools[toolsToNumbers['line']].magnitude - 1]
        iconX = ctPaintTools[toolsToNumbers['line']].clickRegion[0]
        iconY = ctPaintTools[toolsToNumbers['line']].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)

    if tH[tH.length - 1].name is 'point'
      theImage = fancyResponsiveIcons['point'][1][tH[tH.length - 1].magnitude - 1]
      iconX = tH[tH.length - 1].clickRegion[0]
      iconY = tH[tH.length - 1].clickRegion[1]
      toolbar0Context.drawImage( theImage, iconX, iconY )
    else
      if ctPaintTools[toolsToNumbers['point']].magnitude > 1
        theImage = 
          fancyResponsiveIcons['point'][0][ctPaintTools[toolsToNumbers['point']].magnitude - 1]
        iconX = ctPaintTools[toolsToNumbers['point']].clickRegion[0]
        iconY = ctPaintTools[toolsToNumbers['point']].clickRegion[1]
        toolbar0Context.drawImage( theImage, iconX, iconY)


  toolbar1Context.fillStyle = '#202020'
  toolbar1Context.fillRect(0,0,window.innerWidth,toolbarHeight)

  toolbar1Context.drawImage(toolbar1sImage0, 3, 2)
  drawLine(toolbar1Context, [16, 20, 8], toolbarWidth - 1, 0, window.innerWidth, 0)
  toolbar1Context.drawImage(toolbar1sImage1, 188, 3)
  toolbar1Context.drawImage(toolbar1sImage1, 458, 3)
  drawLine(toolbar1Context, [16, 20, 8], toolbarWidth - 1, 0, window.innerWidth, 0)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[0])
  toolbar1Context.fillRect(7,4,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[1])
  toolbar1Context.fillRect(24,4,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[2])
  toolbar1Context.fillRect(16,21,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[3])
  toolbar1Context.fillRect(33,21,14,14)

  paletteIndex = 0
  while paletteIndex < colorPalette.length
    toolbar1Context.fillStyle = rgbToHex(colorPalette[paletteIndex])
    toolbar1Context.fillRect(52 + (17 * (paletteIndex // 2)), 4 + (17 * (paletteIndex % 2)),14,14)
    paletteIndex++

  drawInformationToolbar0()

updateCursor = ->
  coverUpOldCursor()
  cursorX = event.clientX - (toolbarWidth + 5 - canvasXOffset)
  cursorY = event.clientY - 5 - canvasYOffset
  updateOldCursor()
  oldCursorX = cursorX
  oldCursorY = cursorY
  putPixel( ctContext, [239, 8, 8, 255], cursorX, cursorY)

coverUpOldCursor = ->
  if oldCursorsColor isnt undefined
    putPixel( ctContext, oldCursorsColor.data, oldCursorX, oldCursorY )

updateOldCursor = ->
  oldCursorsColor = ctContext.getImageData(cursorX, cursorY, 1, 1)

modeToGlyph = () ->
  if tH[tH.length - 1].modeCapable
    if tH[tH.length - 1].mode
      return ',T'
    else
      return ',F'
  else
    return '  '

magnitudeToGlyph = () ->
  if typeof tH[tH.length - 1] is 'string'
    return ' '
  else
    return tH[tH.length - 1].magnitude.toString(16).toUpperCase()

drawInformation = ( extraInformation ) ->
  toolbar1Context.drawImage(toolbar1sImage1,188,3)   
  drawInformationToolbar0()
  drawInformationToolbar1( extraInformation )

drawInformationToolbar1 = ( extraInformation ) ->
  if extraInformation is undefined
    extraInformation = ''
  toolbar1Context.drawImage(toolbar1sImage1,188,3)   
  toolbar1Context.drawImage(toolbar1sImage1,458,3)   
  xPos = event.clientX - (toolbarWidth + 5) - canvasXOffset
  yPos = event.clientY - 5 - canvasYOffset
  colorValue = getColorValue(ctContext, xPos, yPos).toUpperCase()
  coordinates = ', (' + xPos.toString() + ', ' + yPos.toString() + ')'
  colorAndCoordinates = colorValue + coordinates
  drawStringAsCommandPrompt(toolbar1Context, colorAndCoordinates, 0, 191, 12)
  drawStringAsCommandPrompt(toolbar1Context, extraInformation, 0, 461, 12)

drawInformationToolbar0 = ->
  #toolbarInformation = magnitudeToGlyph() + modeToGlyph()
  #drawStringAsCommandPrompt(toolbar0Context, toolbarInformation, 0, 6, 104)

getMousePositionOnCanvas = (event) ->
  xSpot = event.clientX - (toolbarWidth + 5) - canvasXOffset
  ySpot = event.clientY - 5 - canvasYOffset

getMousePositionOnZoom = (event) ->
  xSpotZoom = event.clientX - (toolbarWidth)
  ySpotZoom = event.clientY - (toolbarHeight)

scaleCanvasBigger = ( factor ) ->
  ctCanvas.style.width = (factor * ctCanvas.width).toString()+'px'
  ctCanvas.style.height = (factor * ctCanvas.height).toString()+'px'

historyUpdate = ->
  coverUpOldCursor()
  cH.push ctCanvas.toDataURL()
  cH.shift()
  cF = []
  updateCursor()

copeWithSelection = (atZeroZero)->
  copeX = selectionX
  copeY = selectionY
  if atZeroZero is undefined
    atZeroZero = false
  if areaSelected
    areaSelected = false
    canvasDataAsImage = new Image()
    canvasDataAsImage.onload = ->
      ctContext.drawImage(canvasDataAsImage, 0, 0)
      ctContext.putImageData(selection, copeX, copeY)
      cH.push ctCanvas.toDataURL()
      cH.shift()
      cF = []
    canvasDataAsImage.src = cH[cH.length - 1]

