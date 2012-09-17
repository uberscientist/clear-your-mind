i = 0
score = 0
wormRate = 5000
round = 1
wormBirth = false
once = true
emitterActive = false

wormEmitter = (x, y, num) ->
  self.wormNum = num * 9
  emitterActive = true
  w = self.setInterval ->
    i++
    self.wormNum--
    if self.wormNum <= 0
      clearInterval(w)
      emitterActive = false
    else if round < 6
      createWorm(x,y,i)
  , wormRate

createWorm = (x,y,i) ->
  windowH = $(window).height()
  windowW = $(window).width()
  jake = $('#sitting-jake')
  jakePos = jake.position()
  jakeW = jake.width()
  jakeH = jake.height()

  dir = if x > windowW/2 then 'l' else 'r'
  if x > windowW/2
    x += 100
    dirOffset = jakeW*.7
  else
    x -= 100
    dirOffset = -1*jakeW*.7

  sprite = "imgs/worm_crawl_#{dir}.gif"

  setTimeout ->
    $("body").append("<img id='#{i}' class='worm' src='#{sprite}' />")
    wormBirth = true
    worm = $("##{i}")
    worm.css('left' : x,
             'top'  : y)
    worm.animate(
      'left' : jakePos.left + dirOffset,
      'top'  : jakePos.top + .1*jakeH
    (Math.random() * 6000 + 5500) - round*600, 'linear'
    , () ->
      worm.attr('src', "imgs/worm_bite_#{dir}.gif")
      $('audio#worm-wowow').trigger('play')
      $("body").append("<span id='score-#{i}' class='score'>-20</span>")
      score -= 20
      $('#score-display').html(score)
      scoreSpan = $("#score-#{i}")
      scoreSpan.css(
        'color': 'red',
        'top': jakePos.top - 50,
        'left': jakePos.left + 20,
        'z-index': -i-5)
      worm.fadeOut(900, () -> worm.remove())
      scoreSpan.fadeOut(900, () -> scoreSpan.remove())
    )

    worm.mousedown((e) ->
      worm.unbind('mousedown')
      $('audio#zap').trigger('play')
      worm.stop().attr('src', "imgs/worm_stand_#{dir}.gif")
      worm.css('z-index': -i)
      $("body").append("<span id='score-#{i}' class='score'>+10</span>") unless $("#score-#{i}").length > 0
      score += 10
      $('#score-display').html(score)
      scoreSpan = $("#score-#{i}")
      scoreSpan.css(
        'top': e.pageY - 50,
        'left': e.pageX)
      worm.fadeOut(500, () -> worm.remove())
      scoreSpan.animate({'top': '20px'}, 200).fadeOut(800, () -> scoreSpan.remove())
    )

  , Math.random() * 500 + 2000

startRound = () ->
  windowH = $(window).height()
  windowW = $(window).width()

  #Worm Emitters
  wormEmitter(windowW,0, round)
  wormEmitter(0,0, round)
  $('audio#worm-loop').trigger('play')
  $("audio#kw-taunt-#{round}").trigger('play') unless round > 5

  clearInterval(check)
  check = setInterval ->
    if score < 0
      $('#score-display').css('color', 'red')
    else
      $('#score-display').css('color', '#35B94D')

    if round == 6
      endRound()
      once = false
      clearInterval(check)

    else if $('.worm').length == 0 and wormBirth == true and !emitterActive
      $('audio#worm-loop').trigger('pause')
      round++
      message("Round #{round}", '', 3) unless round > 5
      wormRate -= 1000
      wormBirth = false
      startRound()
  , 1000

endRound = () ->
  if once
    wormBirth = false
    $('audio').trigger('pause')
    $('#score-display').remove()
    $('audio#menu-loop').trigger('play')
    finalMsg = "Your score of #{score} "
    finalMsg += if score > 1000 then "is good, the password is `pits`" else "needs improvement to get the password buddy."
    if score < 0 then finalMsg += "  You didn't even try did you?"
    message("Final Score: #{score}", finalMsg, -1)

window.startGame = () ->
  i = 0
  score = 0
  wormRate = 5000
  round = 1
  wormBirth = false
  once = true
  emitterActive = false
  $('audio#menu-loop').trigger('pause')
  $('audio#wormlevel-music').trigger('play')
  startRound()
  message("Round #{round}", 'Click on the wittle wormies to zap them from your consciousness', 7)
  $('body').css(
    'background-image': 'url(\'imgs/kingworm.svg\')',
    'background-repeat': 'no-repeat',
    'background-position': 'center',
    'background-attachment': 'fixed'
   )

  $('body').append("<div id='score-display'></div>")
