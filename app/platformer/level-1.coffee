class Level1
  create: ->
    @player = game.add.sprite game.world.centerX, game.world.centerY, 'player'
    @player.anchor.setTo 0.5
