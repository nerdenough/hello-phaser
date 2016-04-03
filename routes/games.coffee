express = require 'express'
router = express.Router()

# GET: /games/flappy-bird
router.get '/flappy-bird', (req, res) ->
  res.render 'games/flappy-bird',
    title: 'Flappy Bird'

# GET: /games/platformer
router.get '/platformer', (req, res) ->
  res.render 'games/platformer',
    title: 'Platformer'

module.exports = router
