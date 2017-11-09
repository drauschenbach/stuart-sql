local class = require 'middleclass'

local LongType = class('LongType')

LongType.defaultSize = 8
LongType.simpleName = 'bigint'
LongType.typeName = 'long'

function LongType:__eq(other)
  return self.typeName == other.typeName
end

function LongType:asNullable()
  return self
end

return LongType
