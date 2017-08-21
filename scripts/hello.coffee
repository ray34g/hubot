# Description:
#   Hubot, be polite and say hello.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Hello or Good Day make hubot say hello to you back
#   Good Morning makes hubot say good morning to you back


cronJob = require('cron').CronJob

hellos = [
    "Well hello there, %",
    "Hey %, Hello!",
    "Mornin', %",
    "Good day, %",
    "Good 'aye!, %"
]
mornings = [
    "Good morning, %",
    "Good morning to you too, %",
    "Good day, %",
    "Good 'aye!, %"
]

module.exports = (robot) ->

    # Hello, World.
    cid = setInterval ->
        return if typeof robot?.send isnt 'function'
        envelope = {}
        robot.send envelope, "Hello, world! @all"
        clearInterval cid
    , 1000

    robot.hear /(hello|good( [d'])?ay(e)?)/i, (msg) ->
        hello = msg.random hellos
        msg.send hello.replace "%", msg.message.user.name

    robot.hear /(^(good )?m(a|o)rnin(g)?)/i, (msg) ->
        hello = msg.random mornings
        msg.send hello.replace "%", msg.message.user.name

    # Test Codes
    ## hear
    robot.hear /Can you hear me?/i, (msg) ->
        msg.send "I hear you."
    ## respond
    robot.respond /Can you respond me?/i, (msg) ->
        msg.send "I respond you."
    ## using message object
    robot.respond /Call my name/i, (msg) ->
        msg.send "Hi, #{msg.message.user.name}"
    ## regular expression
    robot.hear /(マネし|マネす)(.*)/i, (msg) ->
        msg.send "#{msg.match[0]}！"

    ## HTTP Listener
    robot.router.get '/hubot/yes', (request, response) ->
        response.end()
        envelope = {}
        robot.send envelope, "返答：はい"
    robot.router.get '/hubot/no', (request, response) ->
        response.end()
        envelope = {}
        robot.send envelope, "返答：いいえ"
    ## Link button
    robot.hear /返答/i, (msg) ->
        msg.send "( [[はい]](http://192.168.22.101:9999/hubot/yes) / [[いいえ]](http://192.168.22.101:9999/hubot/no)y)"
    ## Files
    robot.hear /open file/i, (msg) ->
        msg.send (read_json "config.json"). ""a


#   ## Cron
#   send = (room, msg) ->
#       response = new robot.Response(robot, {user : {id : -1, name : room}, text : "none", done : false}, [])
#       response.send msg
#
#       ### *(sec) *(min) *(hour) *(day) *(month) *(day of the week)
#   new cronJob('0 0 * * * *', () ->
#       currentTime = new Date
#       send "", "current time is #{new Date().currentTime.getHours()}:00."
#   ).start()
#

