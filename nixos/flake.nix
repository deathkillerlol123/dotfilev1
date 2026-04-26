{
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
      home-manager = {
    	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
      };
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:vic/import-tree";
  };
  outputs = { self, nixpkgs,flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }  
    {
	imports = (inputs.import-tree ./modules);
	systems = [
	    "x86_64-linux"
	    "aarch64-linux"
	    "aarch64-darwin"
	];
    };
}
