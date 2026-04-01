{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
    	url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs,flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
    {
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
}