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
        console.info("Operator:" + config.operator)
        console.info("Checker:" + config.checker)
        # Accept
        if config.operator is msg.envelope.user.name
            return
        else
            msg.finish()
        # Drop
        if /bot$/.test msg.envelope.user.name
            msg.finish()

    ## Files
    robot.hear /open file/i, (msg) ->
        msg.send (read_json "config.json")

load_config = (filename = "config.json") ->
    config = read_json filename

read_json = (path) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + path)
    try
        json = fs.readFileSync FILE_PATH, 'utf8'
        JSON.parse(json)
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'

