local DataTypes = require 'stuart-sql.types.DataTypes'
local moses = require 'moses'

local nonDecimalTypes = {
  --Seq(NullType, DateType, TimestampType, BinaryType, IntegerType, BooleanType, LongType,
  --  DoubleType, FloatType, ShortType, ByteType, StringType, CalendarIntervalType)
  --  .map(t => t.typeName -> t).toMap
  DataTypes.BooleanType,
  DataTypes.FloatType,
  DataTypes.IntegerType,
  DataTypes.LongType,
  DataTypes.StringType
}

local nonDecimalNameToType = moses.reduce(nonDecimalTypes, function(r, t)
  r[t.typeName] = t
  return r
end, {})

local nonDecimalSimpleNameToType = moses.reduce(nonDecimalTypes, function(r, t)
  r[t.simpleName] = t
  return r
end, {})

-- val FIXED_DECIMAL = """decimal\(\s*(\d+)\s*,\s*(\-?\d+)\s*\)""".r

local M = {}

function M.nameToType(name)
  if name == 'decimal' then
    error('not impl yet')
  --elseif FIXED_DECIMAL
  else
    local type = nonDecimalNameToType[name] or nonDecimalSimpleNameToType[name]
    if type == nil then
      error('Failed to convert the JSON string "' .. name .. '" to a data type')
    end
    return type
  end
end

return M
