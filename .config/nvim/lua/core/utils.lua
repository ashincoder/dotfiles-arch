local utils = {}

--- A mapping helper for the ease of creating key bindings
--- @param mode string
--- @param lhs string
--- @param rhs string
--- @param opts string
function utils.map(mode, lhs, rhs, opts)
   local options = { noremap = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- A function for lazyloading plugins after a loop
--- @param plugin string
--- @param timer number
function utils.lazy_load(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end

--- @param definitions table
function utils.define_augroups(definitions)
   for group_name, definition in pairs(definitions) do
      vim.cmd("augroup " .. group_name)
      vim.cmd "autocmd!"

      for _, def in pairs(definition) do
         local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
         vim.cmd(command)
      end

      vim.cmd "augroup END"
   end
end

--- A function to check if the give lsp_client is active
--- @param name string
--- @return boolean
function utils.check_lsp_client_active(name)
   local clients = vim.lsp.get_active_clients()
   for _, client in pairs(clients) do
      if client.name == name then
         return true
      end
   end
   return false
end

function utils.reload_minivim()
   require("modules.configs.statusline").config()
   vim.cmd [[
   :source ~/.config/nvim/init.lua
   :source ~/.config/nvim/lua/core/init.lua
   ]]
   require("core.options").load_options()
   local plugins = require "modules"
   local loader = require "modules.loader"
   loader:load { plugins }
   require "lsp"
   vim.cmd [[
   :source ~/.config/nvim/lua/lsp/init.lua
   :source ~/.config/nvim/lua/lsp/null_ls.lua
   ]]
   local packer = require "packer"
   if packer.on_complete(packer.install()) then
      print "packer.install: Complete"
      loader:cache_reset()
   end
end

return utils
