# Description:
#   Interact with the bgdev.org site
#
# Dependencies:
#   feedparser >= 0.15.2
#   iconv      >= 2.0.5
#   request    >= 2.20.0
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

# Shorten `url` and invoke the callback `cb` with two arguments:
# error: null if the shortening is successful
# shortUrl: the shortened `url`
shorten = (url, cb) ->
  shortener = 'https://www.googleapis.com/urlshortener/v1/url'
  request
    url: shortener
    method: "POST"
    json:
      longUrl: url,
    (error, response, body) ->
      # console.log error, response, body
      cb error, body?.id


module.exports = (robot) ->
  robot.respond /(bgdev|bgd)\s+(\d+)/i, (msg)->
    n = +msg.match[2]
    if n < 1
      msg.reply 'кажи ми сега каква е тази нула...'
      return
    else if n > 4
      msg.reply 'ако плюя над 4 реда, ще ме кикнат ;('
      return

    body = ''
    request('http://www.bgdev.org/rss.php')
    .pipe(Iconv('Windows-1251', 'UTF-8'))
    .on('error', (e) -> msg.reply "#{e}")
    .on('data', (data) ->
      chunk = data.toString()
      body += chunk

      # Check if this is the last chunk we expect
      if /<\/rss>\s*$/.test(chunk)
        FeedParser.parseString(
          body,
          (err, meta, articles) ->
            if err
              msg.send "#{err}"
              return

            # For the first `n` articles: shorten the link and print
            # it out along with the title
            for a in articles[0..(n-1)]
              do (a) ->
                shorten(
                  a.link
                  (error, link) ->
                    # Fallback to original article link in case of error
                    if error
                      link = a.link
                    msg.send "#{link} -> #{a.title}"
                  )
        )
    )
