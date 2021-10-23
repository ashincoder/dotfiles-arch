local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local vimls_root_path = vim.fn.stdpath "data" .. "/lspinstall/vim"
local vimls_binary = vimls_root_path .. "/node_modules/vim-language-server/bin/index.js"

local M = {}
M.setup = function(on_attach, capabilities)
   lspconfig.vimls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { vimls_binary, "--stdio" },
   }
end

return M
