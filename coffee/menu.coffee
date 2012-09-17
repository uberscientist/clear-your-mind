jQuery.ready = () ->
  menuAnimation()
  setupMenu()
  $('#loading').fadeOut(1000)

  $('img').live('dragstart', (e) ->
    e.preventDefault())

  $('#go-menu').live('click', () ->
    mesgDiv = $('div#message')
    mesgDiv.fadeOut(200)
    $('body').css('background-image', 'none')
    $('body').css('background-color': '#4EA0F8')
    $('span.menu-option').hide()
    $('div#menu').show()
    menuAnimation())

  $('#password-text').keydown((e) ->
    if(e.keyCode == 13)
      pass = $('#password-text').val()
      checkPass(pass))

window.message = (title, text, dur) ->
  windowW = $(window).width()
  mesgDiv = $('div#message')
  mesgDiv.css(
    'top': 20,
    'left': .5*windowW - 310,
    'z-index': 10)
  mesgDiv.stop()
  if dur == -1
    mesgDiv.html("<h2>#{title}</h2><br/>#{text}").slideDown(100).append("<br/><input id='go-menu' type='button' value='main menu'/>")
  else
    mesgDiv.html("<h2>#{title}</h2><br/>#{text}").slideDown(100).delay(dur*1000).fadeOut(200)

    mesgDiv.click(() ->
      mesgDiv.stop().fadeOut(300))

menuAnimation = () ->

  windowH = $(window).height()
  windowW = $(window).width()
  jake = $('#sitting-jake')
  jakeW = 450
  jakeH = 280
  jakeRatio = jakeH/jakeW

#Scale jake, and hide him below the screen
  jake.css(
    'width' : windowW*.5,
    'height': jakeRatio * windowW*.5,
    'top'   : windowH,
    'left'  : (windowW/2) - jakeW*.5)

#float jake up to middle of screen
  jake.animate(
    'top': ((windowH/2) - jakeH*.7)
  1000, () ->
    jakePos = jake.position()
    jakeW = jake.width()
    jakeH = jake.height()
    jakeRatio = jakeH/jakeW
    
    $('span#menu-newgame').css(
      'left': jakePos.left - jakeW*.2,
      'top' : jakePos.top + jakeH*.1)
    $('span#menu-password').css(
      'left': jakePos.left + jakeW*.7,
      'top' : jakePos.top + jakeH*.1)
    $('span#menu-info').css(
      'left': jakePos.left + jakeW*.13,
      'top' : jakePos.top - jakeH*.1)

    $('span.menu-option').fadeIn(800)
  )

checkPass = (pass) ->
  switch pass
    when "pits" then window.startPits()
    when "satori"
      window.enterSatori()
    else alert 'Wrong Password'

setupMenu = () ->
  passwordDiv = $('div#password-div')
  infoDiv = $('div#info')

  $('span.menu-option').hover(() ->
    $('audio#zap').trigger('play')
    $(this).css(
      'cursor': 'pointer',
      'font-size': '2.5em')
  ,
    () ->
      $(this).css('font-size': '2em')
  )

  $('span#menu-newgame').click(() ->
    windowH = $(window).height()
    windowW = $(window).width()
    $('div#menu').fadeOut(500,
      () ->
        jake = $('#sitting-jake')
        jakeW = jake.width()
        jakeH = jake.height()
        jakeRatio = jakeH/jakeW

        jake.animate(
          'top'   : 0,
          'left'  : 0,
          'width' : windowW * 2,
          'height': windowW * 2 * jakeRatio
        1000, () ->
          $('body').css('background-color':'#13020C')
          jake.animate(
            'top'   : windowH - (jakeRatio * windowW / 3),
            'left'  : windowW/2 -(windowW / 4),
            'width' : windowW / 8,
            'height': jakeRatio * windowW / 8
          1000, () ->
            window.startGame()
          )
        )))

  $('span#menu-password').click(() ->
    passwordDiv.css('z-index', '10')
    passwordText = $('input#password-text')
    passwordText.val('')
    passwordDiv.slideDown(200, () ->
      passwordText.focus())
  )
  $('span#menu-info').click(() ->
    infoDiv.slideDown(200)
  )

  $('input#password-nope').click(() ->
    passwordDiv.slideUp(200))

  $('input#password-button').click(() ->
    pass = $('#password-text').val()
    checkPass(pass)
  )

  $('input#close-info').click(() ->
    infoDiv.slideUp(200))
