return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- or "latte", "frappe", "macchiato"
        background = {
          light = "latte",
          dark = "mocha",
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
