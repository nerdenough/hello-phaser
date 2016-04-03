class Preloader
  create: ->
    game.load.onLoadStart.add @loadStart, @
    game.load.onFileComplete.add @fileComplete, @
    game.load.onLoadComplete.add @loadComplete, @

    @text = game.add.text 32, 32, 'Loading ...', fill: '#ffffff'

    game.load.image 'player', '../assets/platformer/player.png'
    game.load.start()

  loadStart: ->
    @text.setText 'Loading ...'

  fileComplete: (progress, cacheKey, success, totalLoaded, totalFiles) ->
    @text.setText 'File Complete: ' + progress + '% - ' + totalLoaded +
      ' out of ' + totalFiles

  loadComplete: ->
    @text.setText 'Load Complete'
    game.state.start 'level-1'
