local class = require 'middleclass'
local DataType = require 'stuart-sql.types.DataType'

local StructField = class('StructField')

function StructField:initialize(name, dataType, nullable, metadata)
  self.name = name
  self.nullable = nullable or true
  self.metadata = metadata
  if type(dataType) == 'table' and dataType.__declaredMethods ~= nil then
    self.dataType = dataType
  else
    self.dataType = DataType.nameToType(dataType)
  end
end

function StructField:__eq(other)
  return self.name == other.name
    and self.dataType == other.dataType
    and self.nullable == other.nullable
    --and moses.same(self.metadata, other.metadata)
end

-- override the default toString to be compatible with legacy parquet files
function StructField:__tostring()
  return 'StructField(' .. self.name .. ',' .. tostring(self.dataType) .. ',' .. tostring(self.nullable) .. ')'
end

return StructField
