local class = require 'middleclass'
local parquet = require 'parquet'

local DataFrameReader = class('DataFrameReader')

function DataFrameReader:initialize(sparkSession)
  self.sparkSession = sparkSession
end

function DataFrameReader:format(source)
  self.source = source
  return self
end

function DataFrameReader:schema(schema)
  self.userSpecifiedSchema = schema
  return self
end

function DataFrameReader:parquet(file)
  self:format('parquet')
  local reader = parquet.ParquetReader.openFile(file)
  local cursor = reader:getCursor()
  
  local data = {}
  while true do
    local row = cursor:next()
    if row == nil then break end
    local values = {}
    if row.point and row.point.values and row.point.values.list then
      for i=1,#row.point.values.list do
        values[#values+1] = row.point.values.list[i].element
      end
    end
    data[#data+1] = {row.id, values}
  end
  reader:close()
  
  local df = {
    rdd = function()
      return self.sparkSession.sparkContext:parallelize(data)
    end
  }
  return df
end

return DataFrameReader
