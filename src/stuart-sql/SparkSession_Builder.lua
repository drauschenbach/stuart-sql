local class = require 'middleclass'
local SparkConf = require 'stuart.SparkConf'
local SparkContext = require 'stuart.Context'
local uuid = require 'uuid'

local SparkSession_Builder = class('SparkSession_Builder')

function SparkSession_Builder:initialize()
  self.options = {}
end

function SparkSession_Builder:sparkContext(sparkContext)
  self.userSuppliedContext = sparkContext
  return self
end

function SparkSession_Builder:appName(name)
  return self:config('spark.app.name', name)
end

function SparkSession_Builder:config(arg1, arg2)
  if arg2 == nil then
    --local sparkConf = arg[1]
    error('not impl yet')
  else
    local key, value = arg1, arg2
    self.options[key] = value
  end
  return self
end

function SparkSession_Builder:master(master)
  return self:config('spark.master', master)
end

function SparkSession_Builder:getOrCreate()
  local SparkSession = require 'stuart-sql.SparkSession'
  
  -- If the current thread does not have an active session, get it from the global session.
  local session = SparkSession.getDefaultSession()
  if session ~= nil and not session.sparkContext:isStopped() then
    --options.foreach { case (k, v) => session.sessionState.conf.setConfString(k, v) }
    --if (options.nonEmpty) {
    --  logWarning("Using an existing SparkSession; some configuration may not take effect.")
    --}
    return session
  end
  
  -- No global default session. Create a new one.
  local sparkContext = self.userSuppliedContext
  if sparkContext == nil then
    -- set app name if not given
    local randomAppName = uuid()
    local sparkConf = SparkConf:new()
    for k,v in pairs(self.options) do sparkConf:set(k, v) end
    if not sparkConf:contains('spark.app.name') then
      sparkConf:setAppName(randomAppName)
    end
    --TODO local sc = SparkContext:getOrCreate(sparkConf)
    local sc = SparkContext:new(sparkConf)
    for k,v in pairs(self.options) do sc.conf:set(k, v) end
    if not sc.conf:contains('spark.app.name') then
      sc.conf:setAppName(randomAppName)
    end
    sparkContext = sc
  end
  
  local extensions = nil
  session = SparkSession:new(sparkContext, nil, nil, extensions)
  --options.foreach { case (k, v) => session.sessionState.conf.setConfString(k, v) }
  SparkSession.setDefaultSession(session)
  
  return session
end

return SparkSession_Builder
