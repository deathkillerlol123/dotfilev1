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
      imports = [
        ./nixos.nix
      ];
    };
}