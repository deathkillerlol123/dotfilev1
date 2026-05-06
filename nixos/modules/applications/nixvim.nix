{
  flake.nixosModules.nixvim = {pkgs, ... }: {
    programs.nixvim = {
      enable = true;
      colorschemes.cattpuccin.enable = true;
      plugins.lualine.enable = true;
    };
  };
}