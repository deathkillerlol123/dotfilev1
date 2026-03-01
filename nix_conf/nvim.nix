{config,pkgs, ...}:

{
 home.file."/.config/nvim/init.lua".text = ''
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
 '';
 home.file."/.config/nvim/lazyvim.json".text = ''
 {
   "extras": [
     "lazyvim.plugins.extras.coding.yanky",
     "lazyvim.plugins.extras.editor.dial",
     "lazyvim.plugins.extras.util.dot",
     "lazyvim.plugins.extras.util.mini-hipatterns"
   ],
   "install_version": 8,
   "news": {
     "NEWS.md": "11866"
   },
   "version": 8
 }
 '';
 home.file."/.config/nvim/stylua.toml".text = ''
 indent_type = "Spaces"
 indent_width = 2
 column_width = 120%                                                   
 '';
 home.file."/.config/nvim/lua/plugins/colorscheme.lua".text = ''
 return {
   {
     "LazyVim/LazyVim",
     opts = {
       colorscheme = "catppuccin",
     },
   },
   {
     "navarasu/onedark.nvim",
     priority = 1000, -- make sure to load this before all the other start plugins
     config = function()
       require("onedark").setup({
         style = "deep",
       })
       require("onedark").load()
     end,
   },
   {
     "scottmckendry/cyberdream.nvim",
     lazy = false,
     priority = 1000,
   },
 }
 '';
 home.file."/.config/nvim/lua/plugins/core.lua".text = ''
 return {
   {
     "simrat39/symbols-outline.nvim",
     cmd = "SymbolsOutline",
     keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
     opts = {
       position = "right",
     },
   },
   {
     "hrsh7th/nvim-cmp",
     ---@param opts cmp.ConfigSchema
     opts = function(_, opts)
       local has_words_before = function()
         unpack = unpack or table.unpack
         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
       end
 
       local cmp = require("cmp")
 
       opts.mapping = vim.tbl_extend("force", opts.mapping, {
         ["<Tab>"] = cmp.mapping(function(fallback)
           if cmp.visible() then
             cmp.select_next_item()
           elseif vim.snippet.active({ direction = 1 }) then
             vim.schedule(function()
               vim.snippet.jump(1)
             end)
           elseif has_words_before() then
             cmp.complete()
           else
             fallback()
           end
         end, { "i", "s" }),
         ["<S-Tab>"] = cmp.mapping(function(fallback)
           if cmp.visible() then
             cmp.select_prev_item()
           elseif vim.snippet.active({ direction = -1 }) then
             vim.schedule(function()
               vim.snippet.jump(-1)
             end)
           else
             fallback()
           end
         end, { "i", "s" }),
       })
     end,
   },
   {
     "nvim-lua/plenary.nvim",
     lazy = true,
   },
   {
     "kiyoon/python-import.nvim",
     lazy = false,
     build = "uv tool install . --force --reinstall",
     keys = {
       {
         "<space><space>",
         function()
           require("python_import.api").add_import_current_word_and_notify()
         end,
         mode = { "i", "n" },
         silent = true,
         desc = "Add python import",
         ft = "python",
       },
       {
         "<M-CR>",
         function()
           require("python_import.api").add_import_current_selection_and_notify()
         end,
         mode = "x",
         silent = true,
         desc = "Add python import",
         ft = "python",
       },
       {
         "<space>c",
         function()
           require("python_import.api").add_import_current_word_and_move_cursor()
         end,
         mode = "n",
         silent = true,
         desc = "Add python import and move cursor",
         ft = "python",
       },
       {
         "<space>i",
         function()
           require("python_import.api").add_import_current_selection_and_move_cursor()
         end,
         mode = "x",
         silent = true,
         desc = "Add python import and move cursor",
         ft = "python",
       },
       {
         "<space>tr",
         function()
           require("python_import.api").add_rich_traceback()
         end,
         silent = true,
         desc = "Add rich traceback",
         ft = "python",
       },
     },
     opts = {
       extend_lookup_table = {
         ---@type string[]
         import = {},
         ---@type table<string, string|vim.NIL>
         import_as = {},
         ---@type table<string, string|vim.NIL>
         import_from = {},
         ---@type table<string, string[]|vim.NIL>
         statement_after_imports = {},
       },
       ---@type fun(winnr: integer, word: string, ts_node: TSNode?): string[]?
       custom_function = function(winnr, word, ts_node) end,
     },
   },
   {
     "rcarriga/nvim-notify", -- optional
     lazy = true,
   },
   {
     "elihunter173/dirbuf.nvim",
     lazy = true,
   },
   {
     "stevearc/oil.nvim",
     lazy = true,
   },
   {
     "lervag/vimtex",
     lazy = false, -- we don't want to lazy load VimTeX
     init = function()
       vim.g.vimtex_view_method = "zathura"
       vim.g.vimtex_compiler_method = "latexmk"
     end,
   },
   {
     "nvim-telescope/telescope.nvim",
     tag = "0.1.8",
     dependencies = { "nvim-lua/plenary.nvim" },
   },
   {
     "okuuva/auto-save.nvim",
     version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
     cmd = "ASToggle", -- optional for lazy loading on command
     event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
     opts = {
       -- your config goes here
     },
   },
   {
     "hat0uma/csvview.nvim",
     ---@module "csvview"
     ---@type CsvView.Options
     opts = {
       parser = { comments = { "#", "//" } },
       keymaps = {
         textobject_field_inner = { "if", mode = { "o", "x" } },
         textobject_field_outer = { "af", mode = { "o", "x" } },
         jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
         jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
         jump_next_row = { "<Enter>", mode = { "n", "v" } },
         jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
       },
     },
     cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
   },
   {
     "jbyuki/nabla.nvim",
   },
   {
     "gaoDean/autolist.nvim",
     ft = {
       "markdown",
       "text",
       "tex",
       "plaintex",
       "norg",
     },
     config = function()
       require("autolist").setup()
 
       vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
       vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
       -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
       vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
       vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
       vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
       vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
       vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")
 
       vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
       vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })
       vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
       vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
       vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
       vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
     end,
   },
 }
 '';
 home.file."/.config/nvim/lua/plugins/snips.lua".text = ''
 return {
   {
     "L3MON4D3/LuaSnip",
     version = "v2.*", -- follow latest release
     dependencies = { "rafamadriz/friendly-snippets" },
     build = "make install_jsregexp",
     config = function()
       require("luasnip.loaders.from_vscode").lazy_load()
     end,
   },
   {
     "rafamadriz/friendly-snippets",
   },
   {
     "kevinm6/snippets",
   },
 }
 '';
 home.file."/.config/nvim/lua/config/autocmds.lua".text = ''
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
 '';
 home.file."/.config/nvim/lua/config/keymaps.lua".text = ''
  -- Keyvim.keymap.sets are automatically loaded on the VeryLazy event
  -- Default keyvim.keymap.sets that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keyvim.keymap.sets.lua
  -- Add any additional keyvim.keymap.sets here
  
  -- tabs
  vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
  vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
  vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
  vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
  vim.keymap.set("n", "<leader><tab>d", "<cmd>tabnext<cr>", { desc = "Next Tab" })
  vim.keymap.set("n", "<leader><tab>w", "<cmd>tabclose<cr>", { desc = "Close Tab" })
  vim.keymap.set("n", "<leader><tab>a", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
  
  --luasnips
  
  local ls = require("luasnip")
  
  vim.keymap.set({ "i" }, "<C-K>", function()
    ls.expand()
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-L>", function()
    ls.jump(1)
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-J>", function()
    ls.jump(-1)
  end, { silent = true })
  
  vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true })
  
  --requires
  require("config.basickeymaps")
  '';
  home.file."/.config/nvim/lua/config/lazy.lua".text = ''
 local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
 if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
   if vim.v.shell_error ~= 0 then
     vim.api.nvim_echo({
       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
       { out, "WarningMsg" },
       { "\nPress any key to exit..." },
     }, true, {})
     vim.fn.getchar()
     os.exit(1)
   end
 end
 vim.opt.rtp:prepend(lazypath)
 
 require("lazy").setup({
   spec = {
     -- add LazyVim and import its plugins
     { "LazyVim/LazyVim", import = "lazyvim.plugins" },
     -- import/override with your plugins
     { import = "plugins" },
     -- { import = "plugins.lsp" },
   },
   defaults = {
     -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
     -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
     lazy = false,
     -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
     -- have outdated releases, which may break your Neovim install.
     version = false, -- always use the latest git commit
     -- version = "*", -- try installing the latest stable version for plugins that support semver
   },
   install = { colorscheme = { "tokyonight", "habamax" } },
   checker = {
     enabled = true, -- check for plugin updates periodically
     notify = false, -- notify on update
   }, -- automatically check for plugin updates
   performance = {
     rtp = {
       -- disable some rtp plugins
       disabled_plugins = {
         "gzip",
         -- "matchit",
         -- "matchparen",
         -- "netrwPlugin",
         "tarPlugin",
         "tohtml",
         "tutor",
         "zipPlugin",
       },
     },
   },
   {
     "mireq/luasnip-snippets",
     dependencies = { "L3MON4D3/LuaSnip" },
     init = function()
       -- Mandatory setup function
       require("luasnip_snippets.common.snip_utils").setup()
     end,
   },
   {
     "L3MON4D3/LuaSnip",
     version = "2.*",
     build = "make install_jsregexp",
     dependencies = {
       "nvim-treesitter/nvim-treesitter",
     },
     init = function()
       local ls = require("luasnip")
       ls.setup({
         -- Required to automatically include base snippets, like "c" snippets for "cpp"
         load_ft_func = require("luasnip_snippets.common.snip_utils").load_ft_func,
         ft_func = require("luasnip_snippets.common.snip_utils").ft_func,
         -- To enable auto expansin
         enable_autosnippets = true,
         -- Uncomment to enable visual snippets triggered using <c-x>
         -- store_selection_keys = '<c-x>',
       })
       -- LuaSnip key bindings
       vim.keymap.set({ "i", "s" }, "<Tab>", function()
         if ls.expand_or_jumpable() then
           ls.expand_or_jump()
         else
           vim.api.nvim_input("<C-V><Tab>")
         end
       end, { silent = true })
       vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
         ls.jump(-1)
       end, { silent = true })
       vim.keymap.set({ "i", "s" }, "<C-E>", function()
         if ls.choice_active() then
           ls.change_choice(1)
         end
       end, { silent = true })
     end,
   },
 })
 '';
}
