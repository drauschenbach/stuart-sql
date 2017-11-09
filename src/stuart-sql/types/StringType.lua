local class = require 'middleclass'

local LongType = class('LongType')

LongType.defaultSize = 20
LongType.simpleName = 'string'
LongType.typeName = 'string'

function LongType:__eq(other)
  return self.typeName == other.typeName
end

function LongType:asNullable()
  return self
end

return LongType
