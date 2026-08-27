{...}: {
  flake.homeModules.mango = {inputs, ...}: {
    imports = [inputs.mango.hmModules.mango];
  };
}
