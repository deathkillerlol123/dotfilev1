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
    modules = with self.nixosModules; [users];
  };
  flake.nixosModules.users = {...}: {
    imports = with self.nixosModules; [main-user nixboom];
    main-user.users = {
      nixboom = {
        enable = true;
        shell = "nushell";
        groups = ["wheel" "gamemode" "uinput"];
      };
      doct = {
        enable = false;
        groups = ["wheel" "gamemode"];
      };
    };
  };
}
