game = new Phaser.Game 400, 490

mainState =
  preload: ->
    game.load.image 'bird', 'assets/bird.png'
    game.load.image 'pipe', 'assets/pipe.png'

  create: ->
    game.stage.backgroundColor = '#5095e6'
    game.physics.startSystem Phaser.Physics.ARCADE

    this.score = 0
    this.labelScore = game.add.text 20, 20, '0',
      font: '30px Arial'
      fill: '#ffffffff'

    this.bird = game.add.sprite 100, 245, 'bird'
    game.physics.arcade.enable this.bird
    this.bird.body.gravity.y = 1000

    this.pipes = game.add.group()
    this.timer = game.time.events.loop 1500, this.addRowOfPipes, this

    spaceKey = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
    spaceKey.onDown.add this.jump, this

  update: ->
    if this.bird.y < 0 or this.bird.y > 490
      this.restartGame()

    game.physics.arcade.overlap this.bird, this.pipes, this.restartGame,
      null, this

  jump: ->
    this.bird.body.velocity.y = -350

  restartGame: ->
    game.state.start 'main'

  addOnePipe: (x, y) ->
    pipe = game.add.sprite x, y, 'pipe'
    this.pipes.add pipe

    game.physics.arcade.enable pipe
    pipe.body.velocity.x = -200

    pipe.checkWorldBounds = true
    pipe.outOfBoundsKill = true

  addRowOfPipes: ->
    this.score += 1
    this.labelScore.text = this.score

    hole = Math.floor(Math.random() * 5) + 1
    for i in [0 .. 12]
      if i != hole and i != hole + 1
        this.addOnePipe 400, i * 40 + 10

game.state.add 'main', mainState
game.state.start 'main'
