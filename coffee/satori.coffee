
window.enterSatori = () ->
  $("audio").trigger("pause")
  $("audio#satori").trigger("play")
  $("audio#menu-loop").trigger("play")
  $("audio#end-loop").trigger("play")

  $("div#menu").fadeOut(200)
  $("div#password-div").fadeOut(200)
  $("body").css("background-color", "#170033")
  jake = $("img#sitting-jake")
  jake.css("z-index", "-10")
  randJakeFloat()
  wormDance()
  setTimeout ->
    message("Thanks for Playing!", "I hope this game guided you closer to glob, feel free to email me <a href='mailto:uberscientist@gmail.com'>uberscientist@gmail.com</a>.", 10)
  , 10*1000

getRand = () ->
  jake = $("img#sitting-jake")

  ww = $(window).width()
  wh = $(window).height()

  randLeft = Math.random() * ww
  randTop = Math.random() * wh

  randLeft = if randLeft > ww - jake.width() then randLeft - jake.width() else randLeft
  randTop = if randTop > wh - jake.height() then randTop - jake.height() else randTop

  coord = [randLeft, randTop]

randJakeFloat = () ->
  blur = 0
  jake = $("img#sitting-jake")

  #setup an interval to animate jake
  newpos = setInterval ->
    rnd = getRand()
    blur++
    jake.css('-webkit-filter', "blur(#{blur}px)").css('-moz-filter', "blur(#{blur}px)")
    jake.animate(
      'width': jake.width() - jake.width()/10,
      'height': jake.height() - jake.height()/10
    ,5000).animate(
      'left': rnd[0],
      'top' : rnd[1],
    ,5000)
  , 7000

$("img.satori-sprite").live('mouseover', () ->
  $(this).animate(
    'top': $(window).height() + 300
  , 1500)
  $(this).unbind('mouseover'))

danceType = 0

dance = () ->
  danceType = if danceType > 4 then 0 else danceType
  spriteContainer = $("#sprites")
  spriteContainer.empty()

  ww = $(window).width()
  wh = $(window).height()

  dir = 'r'
  spriteArray = ["worm_crawl_#{dir}.gif",
                  "worm_bite_#{dir}.gif",
                  "snail_thumb.png",
                  "soap.png",
                  "jake_meditate.svg"]

  i = 0
  spriteContainer.append("<img id='#{i}' class='satori-sprite' src='imgs/#{spriteArray[danceType]}' />")
  sw = $("##{i}").width()
  sh = $("##{i}").height()
  $("##{i}").remove()
  rowLen = Math.round(ww/sw) + 1
  columnLen = Math.round(wh/sh) + 1

  topOffset = 0

  for i in [1..columnLen]
    leftOffset = 0
    for j in [1..rowLen]
      if Math.random() > .5
        dir = if j % 2 == 0 then 'r' else 'l'
      else
        dir = if i % 2 == 0 then 'r' else 'l'
      spriteArray = ["worm_crawl_#{dir}.gif",
                      "worm_bite_#{dir}.gif",
                      "snail_thumb.png",
                      "soap.png",
                      "jake_meditate.svg"]
      spriteContainer.append("<img id='#{i}-#{j}' class='satori-sprite' src='imgs/#{spriteArray[danceType]}' />")
      $("##{i}-#{j}").css(
        'left': leftOffset
        'top': topOffset)
      leftOffset += sw
    topOffset += sh

wormDance = () ->
  $("body").append("<div id='sprites'></div>")
  dance(4)
  danceInterval = setInterval ->
    danceType++
    dance()
  , 3000
