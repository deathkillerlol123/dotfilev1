{
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
      nur = {
        url = "github:nix-community/NUR";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
    	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
      };
	flake-parts.url = "github:hercules-ci/flake-parts";
	import-tree.url = "github:vic/import-tree";
	nix-darwin = {
	    url = "github:nix-darwin/nix-darwin/master";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
  };
    outputs = { self, nixpkgs,flake-parts, denix, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }  
    {
	imports = [
	    (inputs.import-tree ./modules)
	];
	systems = [
	    "x86_64-linux"
	    "aarch64-linux"
	    "x86_64-darwin"
	    "aarch64-darwin"
	];
    };
}
