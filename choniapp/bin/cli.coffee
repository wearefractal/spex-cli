#!/usr/bin/env coffee
require('coffee-script');
path = require 'path'
fs = require 'fs'
log = require 'node-log'
commando = {}

# Parse process args to command name and command arguments
parse = ->
  args = process.argv[2...]
  command = args[0]
  args.shift()
  commandPath = path.join __dirname, '../commands/'
  if commandExists commandPath, command
    mainCommand = require commandPath + command
    if mainCommand?.hasOwnProperty 'exe'
      mainCommand.exe commando, args
    else
      defaultHelp commandPath, args
  else
    defaultHelp commandPath, args
      
defaultHelp = (commandPath, args) ->
  if commandExists(commandPath, 'help') and (helpCommand = require(commandPath + 'help')).hasOwnProperty 'exe'
    helpCommand.exe(commando, args)
  else
    files = fs.readdirSync commandPath
    if files
      commands = (path.basename(x, path.extname(x)) for x in files)
      log.info 'Available Commands:'
      log.info('    ' + command) for command in commands
    else
      log.error 'No commands found.'
      
commandExists = (commandPath, command) -> 
  exists = path.existsSync path.join(commandPath, command + '.js')
  exists or= path.existsSync path.join(commandPath, command + '.coffee')
  return exists
    
parse()
