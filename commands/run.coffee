log = require 'node-log'
path = require 'path'
_ = require('slice') (path.resolve __dirname, "..")

spex = _.load 'spex'

readFromDir = _.load 'files.readFromDir'
report      = _.load 'reporting.report'

# $ spex run - Runs all specs in cwd (./specs/)

exports.exe = (cmd, args) ->

  global.RZR = {}
  global.RZR.ENV = 'spex.unit'

  readFromDir process.cwd(), (err, specs) ->      
    if err? then log.error err
    else 
      spex.runSpecs specs, (err, specs) -> 
        if err? then log.error err
        else report specs

