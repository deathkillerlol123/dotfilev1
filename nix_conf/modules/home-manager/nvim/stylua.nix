{config,pkgs, ...}:

{
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
}
