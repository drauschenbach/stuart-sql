local registerAsserts = require 'registerAsserts'
local SparkSession = require 'stuart-sql.SparkSession'

registerAsserts(assert)

describe('DataFrameReader.parquet()', function()
  
  local filename = 'model2-data-part-00003.parquet'
  describe(filename, function()
  
    it('centroids load', function()
      local session = SparkSession.builder():getOrCreate()
      local centroidsDataFrame = session.read:parquet('spec-fixtures/' .. filename)
      local centroids = centroidsDataFrame:rdd():collect()
      assert.not_nil(centroids)
      assert.equal(1, #centroids)
      assert.equal(0, centroids[1][1])
      assert.same({3,4,5}, centroids[1][2])
    end)

  end)
end)
