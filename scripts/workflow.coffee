# Description:
#   Read resource files and manage guides.
#

fs = require 'fs'
sysPath = require 'path'

workflow = "workflow"

module.exports = (robot) ->

    robot.hear /show current step/i, (msg) ->
        msg.send JSON.stringify(step)

    robot.hear /set step ((\d|\w){1,5})/i, (msg) ->
        msg.send "Step " + msg.match[1]
        try
            step = read_step msg.match[1]
            console.info(JSON.stringify(step))
        catch error
            console.error("Unable to read file", error) unless error.code is 'ENOENT'
    

    step = read_step "root"
    
    robot.hear /.*/, (msg) ->
        date = new Date
        user = msg.envelope.user.name
        text = msg.match[0]

        console.info "-----"
        console.info JSON.stringify(msg)
        console.info "-----"

        filter = new RegExp("/a/",'i')
        return

    robot.hear /file.*((\d|\w){1,5})/i, (msg) ->
        doc_index = msg.match[1]
        text = read_document doc_index
        msg.send "file:\n" + text

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


toYmdDate = (date) ->
  Y = date.getFullYear()
  m = ('0' + (date.getMonth() + 1)).slice(-2)
  d = ('0' + date.getDate()).slice(-2)
  return "#{Y}-#{m}-#{d}"

# 時刻を受け取ってhh:mm形式で返す
tohhmmTime = (date) ->
  hh = ('0' + date.getHours()).slice(-2)
  mm = ('0' + date.getMinutes()).slice(-2)
  return "#{hh}:#{mm}"

### feature for development.

write_document = () ->
    return

save_step + () ->

###

