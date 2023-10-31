vim.defer_fn(function()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "vimdoc", "vim", "bash" },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  }
end, 0)
