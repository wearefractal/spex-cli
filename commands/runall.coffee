require 'protege'
path = require 'path'
_ = require('slice') (path.resolve __dirname, "..")

fs   = _.load 'fs'
log  = _.load 'node-log'
spex = _.load 'spex'

readFromDir = _.load 'files.readFromDir'
report      = _.load 'reporting.report'

# $ spex runall - Runs all specs in any spec folders beneath it

exports.exe = (cmd, args) ->

  global.RZR = {}
  global.RZR.ENV = 'spex.unit'


 
  walk process.cwd(), (error, files) ->      

    specs = []

    if error? then log.error error
    else
      for file in files
        if file.contains '.spec' 
          specs.push file unless file.contains 'node_modules'

    spex.runSpecs specs, (error, specs) ->
      
      report specs
      

walk = (dir, next) ->

  results = []

  fs.readdir dir, (err, list) ->
    if err then return next err 
    pending = list.length

    return next null, list unless pending

    list.forEach (file) ->
      file = dir + "/" + file
      fs.stat file, (err, stat) ->
        if stat and stat.isDirectory()
          walk file, (err, res) ->
            results = results.concat(res)
            next null, results unless --pending
        else
          results.push file
          next null, results unless --pending

  


