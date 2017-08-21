# Description:
#     init config and lists
#

fs = require 'fs'
sysPath = require 'path'

config = {}
workflow = "workflow"

module.exports = (robot) ->
    ##  
    config = load_config "config.json"
    console.info("Operator:" + config.operator)
    console.info("Checker:" + config.checker)
    
    robot.hear /.*/, (msg) ->
        # Accept
        if config.operator is msg.envelope.user.name
            console.info("Accepted")
            return
        else if config.checker is msg.envelope.user.name
            console.info("Accepted")
            return
        # Drop
        if /bot$/.test msg.envelope.user.name
            console.info("Dropped")
            msg.finish()

    ## Files
    robot.hear /show config/i, (msg) ->
        msg.send JSON.stringify(config)

load_config = (filename = "config.json") ->
    read_json filename

read_json = (path) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + path)
    console.info("Read:" + FILE_PATH)
    try
        json = fs.readFileSync FILE_PATH, 'utf8'
        JSON.parse(json)
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'

