{
  inputs,
  self,
  ...
}: let
  hostname = "nixbtw";
in {
  flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules; [
      users
    ];
  };
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
  };
}
