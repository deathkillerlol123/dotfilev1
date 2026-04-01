{ inputs, ...}: {
  flake = {
    nixosConfiguration.main = inputs.nixpkgs.lib.nixosSystem {
      systems = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixboom/configuration.nix
	inputs.home-manager.nixosModules.default
      ];
    };
  };
}