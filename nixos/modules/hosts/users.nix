{inputs,self,...}:
{
  flake.nixosModules.users = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      main-user
      dragon
    ];
    main-user.users = {
      nixboom = {
        enable = true;
        groups = ["wheel" "gamemode" "uinput"];
      };
    };
  };
}
