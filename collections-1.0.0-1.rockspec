-- This file was automatically generated for the LuaDist project.

package = "collections"
version = "1.0.0-1"
-- LuaDist source
source = {
  tag = "1.0.0-1",
  url = "git://github.com/LuaDist-testing/collections.git"
}
-- Original source
-- source = {
--    url = "git://github.com/ClockVapor/collections"
-- }
description = {
   summary = "Provides basic collection classes for Lua",
   homepage = "https://github.com/ClockVapor/collections",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      array_list = "src/array_list.lua"
   }
}