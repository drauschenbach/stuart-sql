package = "stuart-sql"
version = "0.1.0-0"
source = {
   url = "https://github.com/BixData/stuart-sql/archive/0.1.0.tar.gz",
   dir = "stuart-sql-unreleased"
}
description = {
   summary = "A native Lua implementation of Spark SQL",
   detailed = [[
      A native Lua implementation of Spark SQL, designed for
      use with Stuart, the Spark runtime for embedding and edge
      computing.
   ]],
   homepage = "https://github.com/BixData/stuart-sql",
   maintainer = "David Rauschenbach",
   license = "Apache 2.0"
}
dependencies = {
   "lua >= 5.1",
   "stuart >= 0.1.2"
}
build = {
   type = "builtin",
   modules = {
      ["stuart-sql"] = "src/stuart-sql.lua",
      ["stuart-sql.types.BooleanType"] = "src/stuart-sql/types/BooleanType.lua",
      ["stuart-sql.types.DataType"] = "src/stuart-sql/types/DataType.lua",
      ["stuart-sql.types.DataTypes"] = "src/stuart-sql/types/DataTypes.lua",
      ["stuart-sql.types.FloatType"] = "src/stuart-sql/types/FloatType.lua",
      ["stuart-sql.types.IntegerType"] = "src/stuart-sql/types/IntegerType.lua",
      ["stuart-sql.types.LongType"] = "src/stuart-sql/types/LongType.lua",
      ["stuart-sql.types.StringType"] = "src/stuart-sql/types/StringType.lua",
      ["stuart-sql.types.StructField"] = "src/stuart-sql/types/StructField.lua",
      ["stuart-sql.types.StructType"] = "src/stuart-sql/types/StructType.lua"
   }
}
