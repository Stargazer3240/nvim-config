require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

local map = vim.keymap.set

-- See `:help telescope.builtin`
map("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
map("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

map("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Find [G]it [F]iles" })
map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
map("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
map("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind current [W]ord" })
map("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
map("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
map("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[F]ind [R]esume" })
