--
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("FastTermEsc", { clear = true }),
  callback = function(args)
    -- We use a buffer-local mapping with 'nowait' and 'silent'
    -- 'nowait' is the key—it tells Neovim to stop 'thinking' when it sees Esc
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
      buffer = args.buf,
      nowait = true,
      silent = true
    })

    -- This helps the terminal cursor look like Normal Mode immediately
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("FileChangedRO", {
  callback = function()
    vim.bo.readonly = false
  end,
})

vim.opt.swapfile = false
