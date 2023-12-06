local lspconfig = require('lspconfig')
local mason_lsp = require('mason-lspconfig')

require('mason').setup()

mason_lsp.setup {
  ensure_installed = {
    'dockerls',
    'docker_compose_language_service',
    'html',
    'tsserver',
    'rnix',
    'jsonls',
    'lua_ls',
    'cssls'
  },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
    lspconfig[server_name].setup({
        capabilities = capabilities,
    })
end
