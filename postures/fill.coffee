fillPosture = [
  () ->
    updateCursor()
    drawInformation()
  () ->
    mousePressed = true
    getMousePositionOnCanvas(event)
    coverUpOldCursor()
    floodFill(ctCanvas, ctContext, colorSwatches[0], xSpot, ySpot)
    updateOldCursor()
  () ->
    mousePressed = false
    historyUpdate()
  () ->
]

