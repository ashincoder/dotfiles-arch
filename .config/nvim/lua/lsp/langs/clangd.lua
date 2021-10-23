local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local M = {}

M.setup = function(on_attach, capabilities)
   lspconfig.clangd.setup {
      cmd = { "clangd", "--background-index" },
      on_attach = on_attach,
      capabilities = capabilities,
   }
end

return M
