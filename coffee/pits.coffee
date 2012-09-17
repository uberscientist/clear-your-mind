window.startPits = () ->
  message("Hi!", "My pits stink and are full of snails, please grab that soap and help me scrub them squeaky clean!", 14)
  $('audio').trigger('pause')
  $('audio#pits-loop').trigger('play')
  $('div#password-div').slideUp(100)
  $('div#menu').fadeOut(100)
  $('img#sitting-jake').animate(
    'width': 0,
    'height': 0
  , () -> $(self).hide())

  $('div#pits').show()
  startKinetic()

#just to open scope for the stage
stage = null
snailCount = 0
bubblage = 0

randumb = (range) ->
  #returns +/- random number in range
  rand = (-1 * Math.round(Math.random())) * (Math.random() * range)

startKinetic = () ->
  stage = new Kinetic.Stage(
    container: 'pits',
    width: 600,
    height: 600)

  images = new Kinetic.Layer()
  background = new Kinetic.Layer()
  jakeImg = new Image()
  soapImg = new Image()

  soapImg.onload = () ->
    soap = new Kinetic.Image(
      draggable: true,
      x: 50,
      y: 400,
      image: soapImg,
      width: 150,
      height: 120)

    images.add(soap)
    images.draw()

    soap.on('dragstart', (e) ->
      $('audio#pit-wash').trigger('play')
    )
    soap.on('dragend', (e) ->
      $('audio#pit-wash').trigger('pause')
    )
    soap.on('dragmove', (e) ->
      x = e.layerX
      y = e.layerY
      if x > 260 and x < 310 and y > 290 and y < 400
        bubblage += 1
        if bubblage % 2 == 0
          bubbles(x + randumb(25), y + randumb(25))
    )

  jakeImg.onload = () ->
    jake = new Kinetic.Image(
      x: 0,
      y: 0,
      image: jakeImg,
      width: 600,
      height: 600)

    background.add(jake)
    stage.add(background)
    stage.add(bubbleLayer)
    stage.add(images)
    images.draw()

  jakeImg.src = 'imgs/jakespit.png'
  soapImg.src = 'imgs/soap.png'

bubbleLayer = new Kinetic.Layer()
msgArray = ["There's 4 more in there, get them out please!",
            "Ew, keep scrubbing the illusions of self away!",
            "Almost there two more left buddy, I really appreciate it!",
            "My pits are reaching spiritual purity!",
            "Way to go trooper, the password is `satori`"]

bubbles = (x,y) ->
  if bubblage % 300 == 0
    snailCount++
    $('audio#zap').trigger('play')
    dur = if snailCount != 5 then 4 else -1
    message("#{snailCount}/5", msgArray[snailCount-1], dur)

    if snailCount == 5
      snailCount = 0
      $('audio').trigger('pause')
      $('audio#menu-loop').trigger('play')
      $('div#pits').fadeOut(400, () -> $('div#pits').empty())

    snailImg = new Image()
    snailImg.onload = () ->
      snail = new Kinetic.Image(
        x: x,
        y: y,
        image: snailImg,
        width: 77,
        height: 71)
      bubbleLayer.add(snail)

      angularSpeed = Math.PI/2

      anim = new Kinetic.Animation(
        func: (frame) ->
          snail.setY(snail.attrs.y + Math.round(frame.time/200))
          angleDiff = frame.timeDiff * angularSpeed/600
          snail.rotate(angleDiff)
          if snail.attrs.y > 700
            anim.stop()
            bubbleLayer.remove(snail)
        ,
        node: bubbleLayer)
      anim.start()

    snailImg.src = 'imgs/snail_thumb.png'

  bubble = new Kinetic.Circle(
    x: x,
    y: y,
    radius: (Math.random() * 10) + 3,
    fill: "#C5EEF6",
    stroke: "#FFF",
    strokeWidth: 2
    opacity: Math.random() * .8 + .1)

  bubbleLayer.add(bubble)
  bubbleLayer.draw()
  anim = new Kinetic.Animation(
    func: (frame) ->
      bubble.setY(bubble.attrs.y + Math.round(frame.time/1000))
      if bubble.attrs.y > 600
        anim.stop()
        bubbleLayer.remove(bubble)
    ,
    node: bubbleLayer)
  anim.start()
