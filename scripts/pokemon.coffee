# Description:
#   Returns random pokemon
#
# Dependencies:
#   "jsdom": "0.2.14"
#   "underscore.string": "2.3.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot pokemon me - Sends random pokemon
#
# Author:
#   welldan97

jsdom = require 'jsdom'
_  = require 'underscore.string'

module.exports = (robot) ->
  robot.respond /pokemon( me)? (.*)/i, (msg) ->
    pockemonMe msg, msg.match[2], (pokemon) ->
      msg.send pokemon

pockemonMe = (msg, query, cb) ->
  msg.http('http://pokemondb.net/pokedex/national')
    .get() (err, res, body) ->
      jquery = 'http://code.jquery.com/jquery.js'
      jsdom.env body, [jquery], (errors, window) ->
        hrefs = window.$(".item > .pkg").map((i,e) -> window.$(e).attr('href'))
        pokemon = msg.random(hrefs).substring 29
        
        cb "#{_.capitalize(pokemon)}\nhttp://img.pokemondb.net/artwork/#{pokemon}.jpg"

