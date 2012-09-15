jQuery.ready = () ->
  menuAnimation()

$(window).resize( () ->
)

menuAnimation = () ->

  height = $(window).height()
  width = $(window).width()

  jake = $('#sitting-jake')
  jake.css(
    'top' : height
    'left': (width/2) - 180)

  $('span.menu-option').css(
    'left': (width/2) - 120,
    'top' : height + 50)
  
  jake.animate(
    'top': (height/2) - 100
  1000, () ->
    jakePos = jake.position()

    $('span#menu-newgame').animate(
      'left': jakePos.left - 80,
      'top' : jakePos.top + 30,
    500)
    $('span#menu-password').animate(
      'left': jakePos.left + 320,
      'top' : jakePos.top + 30,
    500)
    $('span#menu-info').animate(
      'left': jakePos.left + 100,
      'top' : jakePos.top - 20,
    800, () ->
      setupMenu()))

setupMenu = () ->
  $('span.menu-option').hover(() ->
    $(this).css('cursor': 'pointer'))

  $('span#menu-newgame').click(() ->

  )
  $('span#menu-password').click(() ->
    $('div#password-div').slideDown(500)
  )
  $('span#menu-info').click(() ->

  )
