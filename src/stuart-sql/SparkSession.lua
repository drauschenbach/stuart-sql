local Builder = require 'stuart-sql.SparkSession_Builder'
local class = require 'middleclass'
local DataFrameReader = require 'stuart-sql.DataFrameReader'

local SparkSession = class('SparkSession')

function SparkSession:initialize(sparkContext, _, _, extensions)
  self.sparkContext = sparkContext
  self.extensions = extensions
  self.read = DataFrameReader:new(self)
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
