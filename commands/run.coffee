path = require 'path'
_ = require('slice') (path.resolve __dirname, "..")

spex = _.load 'spex'

readFromDir = _.load 'files.readFromDir'
report      = _.load 'reporting.report'

# $ spex run - Runs all specs in cwd (./specs/)

exports.exe = (cmd, args) ->

  readFromDir path.resolve('./specs'), (specs) ->  
    spex.runSpecs specs, (specs) -> 
      
      report specs

