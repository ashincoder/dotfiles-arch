local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local sh_root_path = vim.fn.stdpath "data" .. "/lspinstall/bash"
local sh_binary = sh_root_path .. "/node_modules/.bin/bash-language-server"

local M = {}

M.setup = function(on_attach, capabilities)
   lspconfig.bashls.setup {
      cmd = { sh_binary, "start" },
      filetypes = { "sh", "zsh" },
      on_attach = on_attach,
      capabilities = capabilities,
   }
end

return M
