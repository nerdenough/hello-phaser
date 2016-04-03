class Level1
  create: ->
    @player = game.add.sprite game.world.centerX, game.world.centerY, 'player'
    @player.anchor.setTo 0.5
    game.physics.arcade.enable @player
    @player.body.gravity.y = 1000

    game.physics.startSystem Phaser.Physics.ARCADE

    @controls =
      left: @input.keyboard.addKey Phaser.Keyboard.A
      right: @input.keyboard.addKey Phaser.Keyboard.D
      spacebar: @input.keyboard.addKey Phaser.Keyboard.SPACEBAR

  update: ->
    @player.body.velocity.x = 0

    if @controls.left.isDown
      @player.body.velocity.x = -200

    if @controls.right.isDown
      @player.body.velocity.x = 200

    if @controls.spacebar.isDown
      @player.body.velocity.y = -350
