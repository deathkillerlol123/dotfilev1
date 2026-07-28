{self, ...}: {
  flake.nixosModules.doct = {...}: {
    imports = with self.nixosModules; [uxplay main];
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    boot.loader = {
      refind.enable = true;
      efi = {
        canTouchEfiVariables = true;
        systemdBoot.enable = false;
      };
    };
  };
}
