# Description:
#   Returns random pokemon
#
# Dependencies:
#   "jsdom": "0.2.14"
#
# Configuration:
#   None
#
# Commands:
#   hubot pokemon
#
# Author:
#   welldan97

jsdom = require 'jsdom'

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
        
        cb "http://img.http://pokemondb.net/artwork/#{pokemon}.jpg"

