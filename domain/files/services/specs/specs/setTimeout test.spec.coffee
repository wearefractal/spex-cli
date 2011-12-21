#>> Setup

useless = require 'useless'

#>> Given a function foo

foo = (num) ->

#>> 1 should = 1

  1.should.equal 1

#>> When I call foo with a delay 

setTimeout foo, 1000  


