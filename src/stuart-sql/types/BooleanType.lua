local class = require 'middleclass'

local BooleanType = class('BooleanType')

BooleanType.defaultSize = 1
BooleanType.simpleName = 'bool'
BooleanType.typeName = 'boolean'

function BooleanType:__eq(other)
  return self.typeName == other.typeName
end

function BooleanType:asNullable()
  return self
end

return BooleanType
