{
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
      home-manager = {
    	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
      };
      helium = {
	  url = "github:AlvaroParker/helium-nix";
	  inputs.nixpkgs.follows = "nixpkgs";
      };
      nur = {
	  url = "github:nix-community/NUR";
	  inputs.nixpkgs.follows = "nixpkgs";
      };
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:vic/import-tree";
  };

  outputs = { self, nixpkgs,flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
    {
	flake = {
	    nixosConfigurations = {
      		nixbtw = nixpkgs.lib.nixosSystem {
      		    system = "x86_64-linux";
      		    specialArgs = {inherit inputs;};
      		    modules = [
			./modules/hosts/nixboom/myMachine.nix
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
#	imports = [
#	    ./modules/common/fonts.nix
#	];
    };
}
