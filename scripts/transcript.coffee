# Description:
#   Returns IPA transcription of the world
#
# Dependencies:
#   "jsdom": "0.2.14"
#   "underscore.string": "2.3.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot transcript me <word> - Send transcription of the word
#
# Author:
#   welldan97

jsdom = require 'jsdom'
_  = require 'underscore.string'

module.exports = (robot) ->
  robot.respond /transcript( me)? (.*)/i, (msg) ->
    transcriptMe msg, msg.match[2], (transcription) ->
      msg.send transcription

transcriptMe = (msg, query, cb) ->
  msg.http('http://upodn.com/phon.asp')
    .query(intext: query,
           ipa: '0')
    .post() (err, res, body) ->
      console.log 'first!!!!!!'
      jquery = 'http://code.jquery.com/jquery.js'
      jsdom.env body, [jquery], (errors, window) ->
        transcription = _.trim window.$('table:eq(0) td:eq(1)').text()
        cb transcription

