-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load("snippets")
--require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/lua/snippets" } })

--require("lsp")

--vim.cmd.colorscheme("catpuccin-mocha")
--vim.cmd.colorscheme("onedark")
vim.cmd.colorscheme("cyberdream")

vim.wo.number = true -- absolute line numbers
vim.wo.relativenumber = false -- disable relative numbers
