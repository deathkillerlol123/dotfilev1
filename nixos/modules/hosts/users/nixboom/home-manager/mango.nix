{...}: {
  flake.homeModules.nbmango = {inputs, ...}: {
    imports = [inputs.mango.hmModules.mango];
  };
}
