{self, ...}: {
  flake.nixosModules.features = {...}: {
    imports = with self.nixosModules; [
      gaming
      bluetooth
      sound
      touch
      intel
      lime
      amd
      uxplay
      clamav
    ];
  };
}
