local filetype_cmds = {
  cpp = "clang++ -o /tmp/$fileNameWithoutExt $fileName && /tmp/$fileNameWithoutExt",
  python = "python3 $fileName",
}

local function build_command()
  local ft = vim.bo.filetype
  local template = filetype_cmds[ft]
  if not template then
    vim.notify("No runner command for filetype: " .. ft, vim.log.levels.WARN)
    return nil
  end

  local cmd = type(template) == "table" and table.concat(template, " ") or template
  local path = vim.fn.expand("%:p")
  local vars = {
    fileNameWithoutExt = vim.fn.fnamemodify(path, ":t:r"),
    fileName = vim.fn.fnamemodify(path, ":t"),
    file = path,
    dir = vim.fn.fnamemodify(path, ":p:h"),
  }

  cmd = cmd:gsub("%$(%w+)", function(v)
    return vars[v] or "$" .. v
  end)

  if cmd == template then
    cmd = cmd .. " " .. vim.fn.shellescape(path)
  end

  return cmd
end

local function run_in_kitty()
  local command = build_command()
  if not command then
    return
  end

  local dir = vim.fn.expand("%:p:h")
  local shell = vim.env.SHELL or "/bin/bash"
  local id = "cr" .. tostring(os.time()) .. tostring(math.random(100000))

  local ok = pcall(vim.fn.system, {
    "kitty", "@", "launch",
    "--type=os-window",
    "--cwd", dir,
    "--env", "CODE_RUNNER_ID=" .. id,
    shell, "-li",
  })

  if not ok or vim.v.shell_error ~= 0 then
    vim.fn.jobstart({ "kitty", "--directory", dir, "-e", shell, "-li" }, { detach = true })
    return
  end

  vim.defer_fn(function()
    vim.fn.system({
      "kitty", "@", "send-text",
      "--match=env:CODE_RUNNER_ID=" .. id,
      command,
    })
  end, 500)
end


vim.api.nvim_create_user_command("RunCode", run_in_kitty, {})
vim.api.nvim_create_user_command("RunFile", run_in_kitty, {})

vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { desc = "Run code" })
vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { desc = "Run file" })
