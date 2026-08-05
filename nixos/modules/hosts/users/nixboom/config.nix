{self, ...}: {
  flake.nixosModules.nixboom = {lib, ...}: let
    enabled = names: lib.genAttrs names (_: {enable = true;});
    enabledModules = enabled;
  in
    {
      imports = with self.nixosModules; [dragonfly main];
      programs = enabled ["wshowkeys" "mango"];
      services.desktopManager.plasma6.enable = true;
      lime = {
        enable = true;
        params = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
      };
      system.stateVersion = "25.11";
    }
    // enabledModules ["gaming" "ble" "tone" "touch" "intel"];
}
