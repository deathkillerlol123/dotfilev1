{self, ...}: {
  flake.nixosModules.nixboom = {...}: {
    imports = with self.nixosModules; [dragonfly gaming bluetooth sound touch intel lime];
    boot.kernelParams = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
  };
}
