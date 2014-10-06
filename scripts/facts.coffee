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
#   fact (<day> <month> | today | random) - Show a historic fact
#
# Author:
#   aaccurso

hostname ='https://numbersapi.p.mashape.com'

module.exports = (robot) ->
  robot.hear /(random )?fact(s)? (.*)/i, (msg) ->
    args = if msg.match[3] then msg.match[3].split(' ') else []
    fst = args[0]
    snd = args[1]
    if fst == 'today'
      today = new Date()
      day = today.getDate()
      month = today.getMonth() + 1
    else if fst == 'random' || !(fst && snd)
      day = Math.floor(Math.random() * 31)
      month = Math.floor(Math.random() * 12)
    else
      day = fst
      month = snd
    path = "/#{month}/#{day}/date"

    msg.http(hostname + path)
      .query({
        fragment: true
        json: true
      })
      .header('X-Mashape-Key', "#{process.env.HUBOT_MASHAPE_CLIENT_ID || 'rsaiucBvCWmshtvC6jjBvqndWLaYp1jrjxPjsnOtR7XDcmQoGs'}")
      .get() (err, res, body) ->
        data = JSON.parse(body)
        console.log(data)
        if data.found
          intro = if fst == 'today' then 'Today on' else 'On'
          msg.send "#{intro} #{data.year} #{data.text}"
        else msg.send "Fact not found for #{day}/#{month}. Try again!"
