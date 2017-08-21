# Description:
#     init config and lists
#

fs = require 'fs'
sysPath = require 'path'

config = {}
workflow = ""

module.exports = (robot) ->
    load_config

    robot.hear /.*/, (msg) ->
        config.operator
        # Accept
        if config.operator is msg.envelope.user.name
            return
        else
            msg.finish()
        # Drop
        if /bot$/.test msg.envelope.user.name
            msg.finish()

  robot.respond /today ([-+]?\d+)/i, (msg) ->
    num = parseInt(msg.match[1])
    replyDate(msg, num)

  robot.respond /today\s*$/i, (msg) ->
    replyDate(msg, 0)

    ## Files
    robot.hear /open file/i, (msg) ->
        msg.send (read_json "config.json")

set_actor = (config) ->
    


load_config = (filename = "config.json") ->
    config = read_json filename

read_json = (path) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + path)
    try
        json = fs.readFileSync FILE_PATH, 'utf8'
        JSON.parse(json)
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'

