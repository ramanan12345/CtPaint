positionCorners = ->
  if cornersVisible
    $('#border0Div').css('top',(canvasYPos-1+canvasYOffset).toString())
    $('#border0Div').css('left',(canvasXPos-1+canvasXOffset).toString())

    $('#border1Div').css('top',(canvasYPos-1+canvasYOffset).toString())
    $('#border1Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#border2Div').css('top',(canvasYPos+canvasHeight+1+canvasYOffset).toString())
    $('#border2Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#border3Div').css('top',(canvasYPos+canvasHeight+1+canvasYOffset).toString())
    $('#border3Div').css('left',(canvasXPos-1+canvasXOffset).toString())
  
  else
    $('#border0Div').css('top',(window.innerHeight).toString())
    $('#border0Div').css('left',(canvasXPos-1+canvasXOffset).toString())

    $('#border1Div').css('top',(window.innerHeight).toString())
    $('#border1Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#border2Div').css('top',(window.innerHeight).toString())
    $('#border2Div').css('left',(canvasXPos+canvasWidth+1+canvasXOffset).toString())

    $('#border3Div').css('top',(window.innerHeight).toString())
    $('#border3Div').css('left',(canvasXPos-1+canvasXOffset).toString())  

positionCanvas = ->
  $('#ctpaintDiv').css('top', (canvasYPos+canvasYOffset).toString())
  $('#ctpaintDiv').css('left',(canvasXPos+canvasXOffset).toString())

prepareCanvas = ->
  ctContext.canvas.width = canvasWidth
  ctContext.canvas.height = canvasHeight

  ctContext.fillStyle = '#000000'
  ctContext.fillRect(0,0,canvasWidth,canvasHeight)

  positionCanvas()
  positionCorners()

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
  if selectedTool
    toolbar0Context.drawImage(selectedTool.pressedImage[toolViewMode],selectedTool.clickRegion[0],selectedTool.clickRegion[1])

  toolbar1Context.fillStyle = '#202020'
  toolbar1Context.fillRect(0,0,window.innerWidth,toolbarHeight)

  toolbar1Context.drawImage(toolbar1sImage0,3,2)
  drawLine(toolbar1Context,[16,20,8],toolbarWidth-1,0,window.innerWidth,0)
  toolbar1Context.drawImage(toolbar1sImage1,188,3)
  drawLine(toolbar1Context,[16,20,8],toolbarWidth-1,0,window.innerWidth,0)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[0])
  toolbar1Context.fillRect(7,4,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[1])
  toolbar1Context.fillRect(24,4,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[2])
  toolbar1Context.fillRect(16,21,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorSwatches[3])
  toolbar1Context.fillRect(33,21,14,14)

  palleteIndex = 0
  while palleteIndex < colorPallete.length
    toolbar1Context.fillStyle = rgbToHex(colorPallete[palleteIndex])
    toolbar1Context.fillRect(52 + (17 * Math.floor(palleteIndex/2)), 4 + (17 * (palleteIndex%2)),14,14)
    palleteIndex++

  drawInformationToolbar0()

modeToGlyph = (tool) ->
  if tool.modeCapable
    if tool.mode
      return ',T'
    else
      return ',F'
  else
    return '  '

magnitudeToGlyph = (tool) ->
  if typeof selectedTool.maxMagnitude == 'string'
    return ' '
  else
    return selectedTool.magnitude.toString(16).toUpperCase()

drawInformationToolbar1 = ->
  drawStringAsCommandPrompt(toolbar1Context, getColorValue(ctContext, event.clientX - (toolbarWidth + 5) - canvasXOffset, event.clientY - 5 - canvasYOffset).toUpperCase() + ', (' + (event.clientX - (toolbarWidth + 5) - canvasXOffset).toString() + ', ' + (event.clientY - 5 - canvasYOffset).toString() + ')', 0, 191, 12)

drawInformationToolbar0 = ->
  drawStringAsCommandPrompt(toolbar0Context, magnitudeToGlyph(selectedTool)+modeToGlyph(selectedTool), 0, 6, 104)

getMousePositionOnCanvas = (event) ->
  xSpot = event.clientX - (toolbarWidth+5) - canvasXOffset
  ySpot = event.clientY - 5 - canvasYOffset

getMousePositionOnZoom = (event) ->
  xSpotZoom = event.clientX - (toolbarWidth)
  ySpotZoom = event.clientY - (toolbarHeight)

scaleCanvasBigger = ( factor ) ->
  console.log 'FACTOR * DIMENSION', factor * ctCanvas.width, factor * ctCanvas.height
  ctCanvas.style.width = (factor * ctCanvas.width).toString()+'px'
  ctCanvas.style.height = (factor * ctCanvas.height).toString()+'px'