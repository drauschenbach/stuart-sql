package = "stuart-sql"
version = "unreleased"
source = {
   url = "https://github.com/BixData/stuart-sql/archive/unreleased.tar.gz",
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
      ["stuart-sql"] = "src/stuart-sql.lua"
   }
}
