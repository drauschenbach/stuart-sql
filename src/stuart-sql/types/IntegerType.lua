local class = require 'middleclass'

local IntegerType = class('IntegerType')

IntegerType.defaultSize = 4
IntegerType.simpleName = 'int'
IntegerType.typeName = 'integer'

function IntegerType:__eq(other)
  return self.typeName == other.typeName
end

function IntegerType:asNullable()
  return self
end

return IntegerType
