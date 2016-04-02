game = new Phaser.Game 400, 490, Phaser.AUTO, 'game'

class MainState
  preload: ->
    game.load.image 'bird', '../assets/flappy-bird/bird.png'
    game.load.image 'pipe', '../assets/flappy-bird/pipe.png'
    game.load.audio 'jump', '../assets/flappy-bird/jump.wav'

  create: ->
    # Scale for mobile browsers
    if game.device.desktop is false
      game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL

      game.scale.setMinMax game.width / 2, game.height / 2,
        game.width, game.height

      game.scale.pageAlignHorizontally = true
      game.scale.pageAlignVertically = true

    # Set background and physics
    game.stage.backgroundColor = '#5095e6'
    game.physics.startSystem Phaser.Physics.ARCADE

    # Initialise the score
    @score = -1
    @labelScore = game.add.text 20, 20, '0',
      font: '30px Arial'
      fill: '#ffffff'

    # Initialise the bird
    @bird = game.add.sprite 100, 245, 'bird'
    game.physics.arcade.enable this.bird
    @bird.body.gravity.y = 1000
    @bird.anchor.setTo -0.2, 0.5

    # Initialise the pipes
    this.pipes = game.add.group()
    @addRowOfPipes()
    @timer = game.time.events.loop 1500, @addRowOfPipes, this

    # Add sound effects
    @jumpSound = game.add.audio 'jump'

    # Set controls
    spaceKey = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
    spaceKey.onDown.add @jump, this
    game.input.onDown.add @jump, this

  update: ->
    # Out of bounds
    if @bird.y < 0 or @bird.y > 490
      @restartGame()

    # Collision detection
    game.physics.arcade.overlap @bird, @pipes, @hitPipe, null, this

    # Rotate the bird
    if @bird.angle < 20
      @bird.angle += 1

  jump: ->
    if @bird.alive is false
      return

    @bird.body.velocity.y = -350
    @jumpSound.play()

    # Reset bird rotation
    animation = game.add.tween this.bird
    animation.to angle: -20, 100
    animation.start()

  restartGame: ->
    game.state.start 'main'

  addOnePipe: (x, y) ->
    pipe = game.add.sprite x, y, 'pipe'
    @pipes.add pipe

    # Move pipes to the left
    game.physics.arcade.enable pipe
    pipe.body.velocity.x = -200

    pipe.checkWorldBounds = true
    pipe.outOfBoundsKill = true

  addRowOfPipes: ->
    @score += 1
    @labelScore.text = @score

    # Generate random hole and fill pipes
    hole = Math.floor(Math.random() * 9) + 1
    for i in [0 .. 12]
      if i != hole and i != hole + 1
        @addOnePipe 400, i * 40 + 10

  hitPipe: ->
    if @bird.alive is false
      return

    @bird.alive = false
    game.time.events.remove @timer
    @pipes.forEach ((p) ->
      p.body.velocity.x = 0
    ), this

game.state.add 'main', MainState
game.state.start 'main'
