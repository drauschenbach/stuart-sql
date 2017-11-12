local registerAsserts = require 'registerAsserts'
local SparkSession = require 'stuart-sql.SparkSession'

registerAsserts(assert)

describe('stuart-sql module', function()

  --local initialSession = SparkSession.builder()
  --  :master('local')
  --  :config('spark.ui.enabled', false)
  --  :config('some-config', 'v2')
  --  :getOrCreate()
  --
  --local sparkContext = initialSession.sparkContext
  

  it('use global default session', function()
    local session = SparkSession.builder():getOrCreate()
    assert.equal(session, SparkSession.builder():getOrCreate())
    SparkSession.clearDefaultSession()
  end)

end)
