# Description:
#   Shorten a url
#
# Dependencies:
#   request    >= 2.20.0
#
# Configuration:
#   None
#
# Commands:
#   trollcho sh|short <url> - Shorten the given url
#
# Author:
#   ydm

request = require 'request'

# TODO: DRY
shorten = (url, cb) ->
  shortener = 'https://www.googleapis.com/urlshortener/v1/url'
  request
    url: shortener
    method: "POST"
    json:
      longUrl: url,
    (error, response, body) ->
      cb error, body?.id

module.exports = (robot) ->
  robot.respond /(sh|short)\s+(.+)/i, (msg)->
    url = msg.match[2]
    shorten url, (error, shortUrl) ->
      msg.reply if shortUrl then shortUrl else "#{error}"
