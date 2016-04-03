class Boot
  create: ->
    game.stage.backgroundColor = '#2c7ca8'
    game.state.start 'preloader'
