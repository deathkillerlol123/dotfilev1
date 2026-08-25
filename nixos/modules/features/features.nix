{...}: {
  flake.nixosModules.features = {self, ...}: {
    imports = with self.nixosModules; [
      gaming
      ble
      tone
      touch
      intel
      lime
      amd
      uxplay
      clamav
    ];
  };
}
