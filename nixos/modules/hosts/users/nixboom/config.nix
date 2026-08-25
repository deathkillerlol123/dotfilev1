{self, ...}: {
  flake.nixosModules.nixboom = {lib, ...}:
    {
      imports = with self.nixosModules; [dragonfly];
      programs.mango.enable = true;
      boot.kernelParams = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
    }
    // lib.genAttrs ["gaming" "ble" "tone" "touch" "intel" "lime"] (_: {enable = true;});
}
