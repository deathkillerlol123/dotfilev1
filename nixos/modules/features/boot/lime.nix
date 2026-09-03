{...}: {
  flake.nixosModules.lime = {...}: {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        limine = {
          enable = true;
          maxGenerations = 3;
        };
      };
    };
  };
}
