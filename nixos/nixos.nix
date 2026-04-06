{inputs, ...}:
{
  flake = {
    nixosConfigurations = {
      nixbtw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixboom/configuration.nix
	  inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
  systems = [
    "x86_64-linux"
    "aarch64-linux"
      "aarch64-darwin"
  ];
}