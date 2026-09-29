return {
  {
    "LazyVim/LazyVim",
    opts = {
      news = {
        lazyvim = false,
        neovim = false,
      },
    },
  },
  -- Disable snacks.nvim built-in terminal so we use native Kitty instead
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        enabled = false,
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "lsp",
            kind = "progress",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
