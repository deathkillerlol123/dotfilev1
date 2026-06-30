{ self, ... }:
{
  flake.nixosModules.users =
    { ... }:
    {
      imports = with self.nixosModules; [
        main-user
        home-man
        nixboom
      ];
      main-user.users = {
        nixboom = {
          enable = true;
          groups = [
            "wheel"
            "gamemode"
            "uinput"
          ];
        };
        doct = {
          enable = false;
          groups = [
            "wheel"
            "gamemode"
          ];
        };
      };
    };
}
