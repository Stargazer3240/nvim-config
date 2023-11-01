---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "go",
    "lua",
    "python",
    "rust",
    "vimdoc",
    "vim",
    "bash",
    "markdown",
    "markdown_inline",
  },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
}
