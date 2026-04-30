{inputs,self,...}:
{
  flake.nixosConfigurations.nixbtw = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-darwin";
    specialArgs = {inherit inputs;};
    modules =
    [
    ];
  };
}