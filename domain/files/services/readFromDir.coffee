_ = require('slice') __dirname

fs      = _.load 'fs'
path    = _.load 'path'
Spec    = _.load('spex').Spec


readFromDir = (cwd, next) ->

  try
    specDir = path.resolve cwd, 'specs'
  catch err
    next new Error 'No /specs dir in current dir'
    
  files = fs.readdirSync specDir
  specs = []
  for file in files
    ext  = path.extname file
    if ext is ".coffee" or ext is ".js"
      specs.push new Spec 
        name: path.basename file, ext
        specDSL: (fs.readFileSync "#{ specDir }/#{ file }").toString()
        isCoffee: (ext is '.coffee')
        specDir: specDir      

  next null, specs

module.exports = readFromDir
