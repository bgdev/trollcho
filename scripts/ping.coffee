# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   trollcho ping - Reply with pong
#   trollcho echo <text> - Reply back with <text>
#   trollcho time - Reply with current time

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send "PONG"

  robot.respond /ECHO (.*)$/i, (msg) ->
    msg.send msg.match[1]

  robot.respond /TIME$/i, (msg) ->
    msg.send "Server time is: #{new Date()}"

