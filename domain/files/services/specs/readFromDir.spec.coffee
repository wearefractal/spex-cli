#>> Setup

require 'should'
_ = require('slice') __dirname

path        = _.load 'path'

Spec        = _.load('spex').Spec
readFromDir = _.load 'files.readFromDir'

#>> Given a directory with some Specs in it

dir = path.resolve __dirname, 'exampleSpecs'

#>> When I pass the dir path to *readFromDir*

readFromDir dir, (specs) ->

#  console.log specs

#>> Then

  specs.length.should.equal 2
  specs[0].name.should.equal "Using an Array as a queue"
  spec.should.be.an.instanceof Spec for spec in specs

