return {
  "nvim-mini/mini.files",
  keys = {
    {
      "<leader>v", -- current file view
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (directory of current file)",
    },
    {
      "<leader>V", -- where neovim was openned
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      "<leader>fm", -- opens at .git
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files (root)",
    },
  },
}
