# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   trollcho ping - Reply with pong
#   trollcho echo <text> - Reply back with <text>
#   trollcho time - Reply with current time
#   trollcho die - End hubot process

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send "PONG"

  robot.respond /ECHO (.*)$/i, (msg) ->
    msg.send msg.match[1]

  robot.respond /TIME$/i, (msg) ->
    msg.send "Server time is: #{new Date()}"

  robot.respond /DIE$/i, (msg) ->
    msg.send "Goodbye, cruel world."
    process.exit 0

