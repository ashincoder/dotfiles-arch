-- Main options
local options = require "core.options"
options.disabled_builtins()
options.load_options()

require "core.autocmds"
require("core.mappings").misc()
require "core.globals"
