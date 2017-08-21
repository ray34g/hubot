# Description:
#   Read resource files and manage guides.
#

fs = require 'fs'
sysPath = require 'path'

module.exports = (robot) ->

    robot.hear /file.*((\d|\w){1-5})/i, (msg) ->
        envelope = {}
        doc_index = 0
        doc_index = msg.match[1] if msg.match[1]
        text = read_document doc_index

        robot.send envelope, text

read_document = (doc_index) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + workflow + '/docs/', doc_index + '.md')
    try
        text = fs.readFileSync FILE_PATH, 'utf8'
    catch error
       console.error("Unable to read file", error) unless error.code is 'ENOENT'

read_step = (step_index) ->
    FILE_PATH = sysPath.join(__dirname, '../api/' + workflow + '/steps/', step_index + '.json')
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

