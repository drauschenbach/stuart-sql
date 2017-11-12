local Builder = require 'stuart-sql.SparkSession_Builder'
local class = require 'middleclass'

local SparkSession = class('SparkSession')

function SparkSession:initialize(sparkContext, _, _, extensions)
  self.sparkContext = sparkContext
  self.extensions = extensions
end

function SparkSession.builder()
  return Builder:new()
end

function SparkSession.clearDefaultSession()
  SparkSession.defaultSession = nil
end

function SparkSession.getDefaultSession()
  return SparkSession.defaultSession
end

function SparkSession.setDefaultSession(session)
  SparkSession.defaultSession = session
end

return SparkSession
