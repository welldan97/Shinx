# Description:
#   Allows Hubot to help you decide between multiple options
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot decide <option1> or <option2> or <optionx> - Randomly picks an option
#
# Authors:
#   logikal
#   welldan97
module.exports = (robot) ->
  robot.respond /decide (.*)/i, (msg) ->
    options = msg.match[1].split(' or ')
    msg.reply("Definitely #{ msg.random options }")
