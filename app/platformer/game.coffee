game = new Phaser.Game 800, 600, Phaser.AUTO, 'game'

game.state.add 'boot', Boot
game.state.add 'preloader', Preloader
game.state.add 'level-1', Level1

game.state.start 'boot'
