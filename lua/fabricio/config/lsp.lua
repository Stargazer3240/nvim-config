vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
  end,
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local default_setup = function(server)
  lspconfig[server].setup {
    capabilities = capabilities,
  }
end

local disable_hover = function(client, _)
  client.server_capabilities.hoverProvider = false
end

local disable_fmt = function(client, _)
  client.server_capabilities.documentFormattingProvider = false
end

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "clangd", "pylsp", "ruff_lsp" },
  handlers = {
    default_setup,

    lua_ls = function()
      require("neodev").setup {}
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
    end,

    pylsp = function()
      lspconfig.pylsp.setup {
        on_attach = disable_fmt,
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = false },
              pyflakes = { enabled = false },
              mccabe = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
            },
          },
        },
      }
    end,

    ruff_lsp = function()
      lspconfig.ruff_lsp.setup {
        on_attach = disable_hover,
      }
    end,
  },
}
