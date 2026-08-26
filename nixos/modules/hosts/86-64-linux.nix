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
    modules = with self.nixosModules; [main users {system.stateVersion = "25.11";}];
  };
  flake.nixosModules.users = {...}: {
    imports =
      [self.nixosModules.main-user]
      ++ (with self.nixosModules; [nixboom]);
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
