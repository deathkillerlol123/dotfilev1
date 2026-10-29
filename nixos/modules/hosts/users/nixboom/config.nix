{self, ...}: {
  flake.nixosModules.nixboom = {
    inputs,
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = with self.nixosModules; [gaming bluetooth sound touch intel lime] ++ [wshowkeys];
    boot.kernelParams = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
    gaming.xbox.enable = true;
  };
}
