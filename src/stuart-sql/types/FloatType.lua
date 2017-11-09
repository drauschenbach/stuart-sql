local class = require 'middleclass'

local FloatType = class('FloatType')

FloatType.defaultSize = 4
FloatType.simpleName = 'float'
FloatType.typeName = 'float'

function FloatType:__eq(other)
  return self.typeName == other.typeName
end

function FloatType:asNullable()
  return self
end

return FloatType
