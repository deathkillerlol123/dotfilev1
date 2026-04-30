{inputs,self,...}:
{
  flake.nixosConfigurations.nixbtw = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
    [
      self.nixosModules.dragboom
    ];
  };
}