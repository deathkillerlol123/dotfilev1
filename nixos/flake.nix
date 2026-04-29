{
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
      nixos-hardware.url = "github:NixOS/nixos-hardware/master";      
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
      treefmt-nix.url = "github:numtide/treefmt-nix";      
  };
  outputs = { self, nixpkgs,flake-parts, ... }@inputs:
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
