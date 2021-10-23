local ok, null_ls = pcall(require, "null-ls")
if not ok then
   return
end
local builtin = null_ls.builtins

local sources = {
   builtin.formatting.prettierd,
   builtin.formatting.trim_whitespace.with { filetypes = { "teal", "zsh" } },

   -- Lua
   builtin.formatting.stylua,
   builtin.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Python
   builtin.formatting.yapf,
   builtin.diagnostics.flake8,

   -- Shell
   builtin.formatting.shfmt,
   builtin.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}
M.setup = function(on_attach)
   null_ls.config {
      -- debug = true,
      sources = sources,
   }
   require("lspconfig")["null-ls"].setup { on_attach = on_attach }
end

return M
