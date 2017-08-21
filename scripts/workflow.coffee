# Description:
#   Read resource files and manage guides.
#

fs = require 'fs'
sysPath = require 'path'

workflow = "workflow"

module.exports = (robot) ->

    step = read_step "root"

    robot.hear /show current step/i, (msg) ->
        msg.send JSON.stringify(step)

    robot.hear /set step ((\d|\w){1,5})/i, (msg) ->
        msg.send "Step " + msg.match[1]
        try
            step = read_step msg.match[1]
            console.info(JSON.stringify(step))
        catch error
            console.error("Unable to read file", error) unless error.code is 'ENOENT'
    
    ## ステップトリガの読み込み処理
    for trigger in step.triggers
        robot.hear new RegExp("#{trigger}", "i"), (msg) ->
            unless step.triggers.indexOf(trigger) is -1
                msg.send "イベントが起きました。" # Do something
            else
                msg.finish()
    

    robot.hear /file.*((\d|\w){1,5})/i, (msg) ->
        doc_index = msg.match[1]
        text = read_document doc_index
        msg.send "file:\n" + text

next_step = (step_index) ->
    try
        step = read_step step_index
        console.info(JSON.stringify(step))
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'

read_document = (doc_index) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + workflow + '/docs/' + doc_index + '.md')
    console.info("Read:" + FILE_PATH)
    try
        text = fs.readFileSync FILE_PATH, 'utf8'
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'

read_step = (step_index) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + workflow + '/steps/' + step_index + '.json')
    console.info("Read:" + FILE_PATH)
    try
        json = fs.readFileSync FILE_PATH, 'utf8'
        JSON.parse(json)
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'


### feature for development.

write_document = () ->
    return

save_step + () ->

###

