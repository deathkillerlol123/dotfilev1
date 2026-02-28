-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_user_command("OpenWord", function()
  local file = vim.fn.input("Word file: ", "", "file")
  if file == "" then return end

  local ext = file:match("^.+(%..+)$")
  local tmpfile = vim.fn.tempname() .. (ext == ".docx" and ".md" or ".txt")

  if ext == ".doc" then
    -- Convert .doc → temporary .txt
    vim.fn.system("libreoffice --headless --convert-to txt:'Text (encoded):UTF8' --outdir " .. vim.fn.shellescape(vim.fn.tempname()) .. " " .. vim.fn.shellescape(file))
    -- LibreOffice always names it file.txt in the output dir
    local converted = vim.fn.glob(vim.fn.tempname() .. "/*.txt")
    if converted == "" then
      print("Failed to convert .doc file")
      return
    end
    tmpfile = converted
  elseif ext == ".docx" then
    -- Convert .docx → temporary Markdown
    vim.fn.system("pandoc " .. vim.fn.shellescape(file) .. " -t markdown -o " .. vim.fn.shellescape(tmpfile))
  else
    print("Not a .doc or .docx file!")
    return
  end

  vim.cmd("edit " .. tmpfile)
end, {})

