class Level1
  create: ->
    map = @add.tilemap 'map', 64, 64
    map.addTilesetImage 'tileset'
    @layer = map.createLayer 0
    @layer.resizeWorld()
    map.setCollisionBetween 0, 2

    @player = game.add.sprite game.world.centerX, game.world.centerY, 'player'
    @player.anchor.setTo 0.5
    game.physics.arcade.enable @player
    @player.body.gravity.y = 1400
    @player.body.collideWorldBounds = true
    @camera.follow @player

    game.physics.startSystem Phaser.Physics.ARCADE

    @controls =
      left: @input.keyboard.addKey Phaser.Keyboard.A
      right: @input.keyboard.addKey Phaser.Keyboard.D
      spacebar: @input.keyboard.addKey Phaser.Keyboard.SPACEBAR

  update: ->
    jumpTimer = jumpTimer or 0
    @physics.arcade.collide @player, @layer
    @player.body.velocity.x = 0

    if @controls.left.isDown
      @player.body.velocity.x = -200

    if @controls.right.isDown
      @player.body.velocity.x = 200

    touching = @player.body.onFloor() or @player.body.touching.down
    if (@controls.spacebar.isDown and touching and @time.now > jumpTimer)
      @player.body.velocity.y = -600
      jumpTimer = @time.now + 750
