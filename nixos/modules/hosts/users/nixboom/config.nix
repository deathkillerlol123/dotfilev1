{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nixboom = {lib, ...}: let
    enabled = names: lib.genAttrs names (_: {enable = true;});
  in {
    imports = [inputs.mango.nixosModules.mango] ++ (with self.nixosModules; [lime dragonfly intel gaming main]);
    programs = enabled ["wshowkeys" "mango"];
    gaming.enable = true;
    ble.enable = true;
    sound.enable = true;
    lime = {
      enable = true;
      params = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
    };
    system.stateVersion = "25.11";
  };
}
