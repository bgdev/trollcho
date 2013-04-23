# Description:
#   Interact with the bgdev.org site
#
# Dependencies:
#   feedparser >= 0.15.2
#
# Configuration:
#   None
#
# Commands:
#   trollcho bgdev|bgd <number> - Echo the last `number` threads
#
# Author:
#   ydm

FeedParser = require 'feedparser'
Iconv = require('iconv').Iconv
request = require 'request'

module.exports = (robot) ->
  robot.respond /(bgdev|bgd)\s+(\d+)/i, (msg)->
    n = parseInt msg.match[2], 10
    if isNaN(n) or n < 1
      msg.reply 'Чичо, параметърът трябва да е цяло положително число под 4'
      return
    else if n > 4
      msg.reply 'Ако плюя над 4 реда, ще ме кикнат ;('
      return

    body = ''
    request('http://www.bgdev.org/rss.php')
    .pipe(Iconv('Windows-1251', 'UTF-8'))
    .on('error', (e) -> msg.reply "#{e}")
    .on('data', (data) ->
      chunk = data.toString()
      body += chunk

      if /<\/rss>\s*/.test(chunk)
        FeedParser.parseString(
          body,
          (err, meta, articles) ->
            n -= 1
            msg.send "#{a.title} –> #{a.link}" for a in articles[0..n]
        )
    )
