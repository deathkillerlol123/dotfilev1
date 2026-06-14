{inputs,self,...}:
let
  user = "doct";
in
{
  flake.nixosModules.doct = {config,lib,pkgs,inputs,...}:{
    imports = with self.nixosModules; [
      uxplay
      main
    ];
    flatpak.apps = ["ch.openboard.OpenBoard"];
  };
}