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
querystring = require('querystring')

options =
  hostname: 'https://numbersapi.p.mashape.com'
  headers:
    'X-Mashape-Key': "#{process.env.HUBOT_MASHAPE_CLIENT_ID}"

module.exports = (robot) ->
  robot.hear /(random )?fact(s)? (.*)/i, (msg) ->
    args = if msg.match[3] then msg.match[3].split(' ') else []
    day = args[0] || Math.floor(Math.random() * 31)
    month = args[1] || Math.floor(Math.random() * 12)
    options.path = "/#{month}/#{day}/date"
    query =
      fragment: true
      json: true
    options.hostname += '?' + querystring.stringify(query)
    console.log(options.hostname)
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
