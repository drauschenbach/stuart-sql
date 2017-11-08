local registerAsserts = require 'registerAsserts'

registerAsserts(assert)

describe('stuart-sql module', function()

  it('loads', function()
    local stuartsql = require 'stuart-sql'
    assert.is_true(stuartsql ~= nil)
  end)
  
end)
