return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  ft = "python",
  keys = {
    { ",v", "<cmd>VenvSelect<cr>" },
  },
  opts = {
    activate_venv_in_terminal = true,
  },
}
