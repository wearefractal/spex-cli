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
  

  walk process.cwd(), (err, files) ->      

    specs = []

    if err? then log.error err
    else
      for file in files
        if file.contains '.spec' 
          specs.push createSpec file unless file.contains 'node_modules'

      spex.runSpecs specs, (err, specs) -> 
        report specs
        
 
createSpec = (filePath) ->
  try
    file = fs.readFileSync filePath    
    ext  = path.extname file
    filePath = filePath.split '/'
    name = filePath.pop()
    return new spex.Spec 
      name: path.basename name, ext
      specDSL: file.toString()
      isCoffee: (ext is '.coffee')
      specDir: path.resolve filePath, '..'    
  catch e
    console.log e

#  readFromDir path.resolve('./specs'), (error, specs) ->     
#    if error then (log.error error.message)
#    else spex.runSpecs specs, (specs) -> report specs


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

  


