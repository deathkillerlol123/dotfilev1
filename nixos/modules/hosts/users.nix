{inputs,self,...}:
let
 m = flake.nixosModules;
in
{
  flake.nixosModules.users = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      main-user
      nixboom
    ];
    main-user.users = {
      nixboom = {
        enable = true;
        groups = ["wheel" "gamemode"];
      };
    };
  };
}
