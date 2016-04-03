class Boot
  create: ->
    game.stage.backgroundColor = '#ad5b5b'
    game.state.start 'preloader'
