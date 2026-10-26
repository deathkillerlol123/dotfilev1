{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.tri = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    programs.zsh = {
      enable = true;
      package = self'.packages.zsh;
    };
  });
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.zsh = inputs.wrappers.wrappers.zsh.wrap {
      inherit pkgs;
      zshAliases = {
        ff = lib.getExe pkgs.fastfetch;
      };
    };
  };
}
