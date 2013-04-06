# Description:
#   Generates help commands for Hubot.
#
# Commands:
#   trollcho help - Displays all of the help commands that Hubot knows about.
#   trollcho help <query> - Displays all help commands that match <query>.
#
# URLS:
#   /hubot/help
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

module.exports = (robot) ->
  robot.respond /help\s*(.*)?$/i, (msg) ->
    msg = "Bot commands -> https://gist.github.com/mytrile/eb64ac49cab34589198f"
    msg.send emit
