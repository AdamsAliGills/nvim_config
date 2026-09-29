-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- File: ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set

local function open_kitty(dir, desc)
  local shell = vim.env.SHELL or "/bin/bash"
  local ok = pcall(vim.fn.system, {
    "kitty", "@", "launch",
    "--type=os-window",
    "--cwd", dir,
    shell, "-li",
  })
  if not ok or vim.v.shell_error ~= 0 then
    vim.fn.jobstart({ "kitty", "--directory", dir, "-e", shell, "-li" }, { detach = true })
  end
end

-- Override LazyVim's default <leader>ft terminal
vim.keymap.del("n", "<leader>ft")
map("n", "<leader>ft", function()
  open_kitty(vim.fn.expand("%:p:h"))
end, { desc = "Terminal (cwd)" })

map("n", "<leader>fT", function()
  open_kitty(vim.fs.root(0, ".git") or vim.fn.getcwd())
end, { desc = "Terminal (Root Dir)" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode", })
-- Use \ as the prefix for debug commands
map("n", "<Bslash><Bslash>", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<Bslash>]", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<Bslash>[", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<Bslash><BS>", function() require("dap").step_back() end, { desc = "Step Back" })

vim.keymap.set("n", "gh", "^", { desc = "Go to first non-whitespace" })
vim.keymap.set("n", "gl", "$", { desc = "Go to end of line" })

vim.keymap.set("n", "<leader>cp", function()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  vim.notify("Copied directory: " .. dir)
end, { desc = "Copy current directory path" })
