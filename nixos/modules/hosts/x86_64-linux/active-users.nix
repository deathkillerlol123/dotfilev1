{inputs,self,...}:
{
  flake.nixosModules.users = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      dragon
    ];
    usersConfig = {
      users = {
        "nixboom" = {
          shell = "fish";
          groups = ["wheel" "gamemode" "uinput"];
        };
      };
    };
  };
}