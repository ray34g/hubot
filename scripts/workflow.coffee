# Description:
#   Read resource files and manage guides.
#

fs = require 'fs'
sysPath = require 'path'

workflow = "workflow"

module.exports = (robot) ->

    robot.hear /file.*(\d)/i, (msg) ->
        console.info("Reading:")
        doc_index = 0
        doc_index = msg.match[1]
        text = read_document doc_index
        msg.send "file:\n" + text

    ## start workflow
    robot.hear /start$/i, (msg) ->
        msg.send "タスクを開始します。"
    ## 
    robot.hear /end$/i, (msg) ->
        msg.send "タスク終了します。"

read_document = (doc_index) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + workflow + '/docs/' + doc_index + '.md')
    console.info("Read:" + FILE_PATH)
    try
        text = fs.readFileSync FILE_PATH, 'utf8'
    catch error
        console.error("Unable to read file", error) unless error.code is 'ENOENT'

read_step = (step_index) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + workflow + '/steps/' + step_index + '.json')
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

