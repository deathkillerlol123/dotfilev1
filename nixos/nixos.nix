{ inputs, ...}: {
  flake = {
    nixosConfiguration.main = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/nixboom/configuration.nix
	inputs.home-manager.nixosModules.default
      ];
    };
  };
}