log = require 'node-log'; log.setName 'spex'
fs = require 'fs'
path = require 'path'

report = (specs) ->

  for spec in specs
    switch spec.status
      when 'pass' then console.log "\n#{ spec.name.green.inverse }\n"
      when 'fail' then console.log "\n#{ spec.name.red.inverse }\n"
      when 'notrun' then console.log "\n#{ spec.name.grey.inverse }\n"
    for scenario in spec.scenarios
      switch scenario.status
        when 'pass' then console.log ":) #{ scenario.name }".green
        when 'fail' then console.log ":( #{ scenario.name }: #{ scenario.error }".red
        when 'notrun' then console.log ":| #{ scenario.name }".grey

  console.log "\n"


module.exports = report

