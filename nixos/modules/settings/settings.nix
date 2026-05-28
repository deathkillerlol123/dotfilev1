{inputs,self,...}:{
  flake.nixosModules.settings = {config,lib,pkgs,inputs,...}:{
    imports = with self.nixosModules; [
    flatpak
    lime
    home-man
    ];
  };
}    