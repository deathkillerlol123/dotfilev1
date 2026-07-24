{self, ...}: {
  flake.nixosModules.users = {...}: let
    fmod = names: map (x: self.nixosModules.${x}) names;
  in {
    imports = fmod ["main-user" "home-man" "nixboom"];
    main-user.users = {
      nixboom = {
        enable = true;
        groups = ["wheel" "gamemode" "uinput"];
      };
      doct = {
        enable = false;
        groups = ["wheel" "gamemode"];
      };
    };
    home-man = {
      enable = true;
      users = [
        "nixboom"
      ];
    };
  };
}
