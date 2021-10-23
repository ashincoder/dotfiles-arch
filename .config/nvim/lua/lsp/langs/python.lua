local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local py_path = vim.fn.stdpath "data" .. "/lspinstall/python"
local py_binary = py_path .. "/node_modules/.bin/pyright-langserver"

local M = {}
M.setup = function(on_attach, capabilities)
   lspconfig.pyright.setup {
      cmd = { py_binary, "--stdio" },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
         python = {
            analysis = {
               typeCheckingMode = false,
               autoSearchPaths = true,
               useLibraryCodeForTypes = true,
            },
         },
      },
   }
end

return M
