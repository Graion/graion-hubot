# Description:
#   Based on https://www.mashape.com/divad12/numbers-1#!documentation
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_MASHAPE_CLIENT_ID
#
# Commands:
#   fact <day> <month>
#
# Author:
#   aaccurso


https = require('https')

options =
  hostname: 'https://numbersapi.p.mashape.com'
  headers:
    'X-Mashape-Key': "#{process.env.HUBOT_MASHAPE_CLIENT_ID}"

module.exports = (robot) ->
  robot.hear /(random )?fact(s)? (.*)/i, (msg) ->
    data = if msg.match[3] then msg.match[3].split(' ') else []
    day = data[0] || Math.floor(Math.random() * 31)
    month = data[1] || Math.floor(Math.random() * 12)
    options.path = "/#{month}/#{day}/date"
    console.log(msg.match)
    console.log(data)
    console.log(day, month)
    msg.send(options.path)

    # https.get(options, (res) ->
    #   if res.statusCode == 200
    #     res.on 'data', (chunk) ->
    #       data.push(chunk)
    #
    #     res.on 'end', () ->
    #       parsedData = JSON.parse(data.join(''))
    #       images = parsedData.data.images
    #       image = images[parseInt(Math.random() * images.length)]
    #
    #       msg.send(image.link)
    # )
