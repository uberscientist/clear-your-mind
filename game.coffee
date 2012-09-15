i = 0
wormNum = 4

wormEmitter = (x, y) ->
  w = self.setInterval ->
    i++
    wormNum--
    if wormNum <= 0
      clearInterval(w)

    console.log wormNum
    createWorm(x,y,i)
  , 3000

createWorm = (x,y,i) ->
  windowH = $(window).height()
  windowW = $(window).width()

  dir = if x > windowW/2 then 'l' else 'r'
  if x > windowW/2
    x += 100
  else
    x -= 100
  sprite = "worm_crawl_#{dir}.gif"

  setTimeout ->
    $("body").prepend("<img id='#{i}' class='worm' src='#{sprite}' />")
    worm = $("##{i}")
    worm.css('left' : x,
             'top'  : y)
    worm.animate(
      'left' : windowW/2,
      'top'  : windowH/2
    Math.random() * 6000 + 8000)
  , Math.random() * 500 + 2000

window.startGame = () ->
  windowH = $(window).height()
  windowW = $(window).width()
  wormEmitter(windowW,0)
  wormEmitter(0,0)
  $('audio#worm-loop').trigger('play')
