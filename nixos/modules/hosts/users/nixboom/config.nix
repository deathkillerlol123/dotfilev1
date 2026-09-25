{self, ...}: {
  flake.nixosModules.nixboom = {
    inputs,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [inputs.nur.overlays.default];
    imports = with self.nixosModules; [gaming bluetooth sound touch intel lime];
    boot.kernelParams = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
    environment.systemPackages = [
      pkgs.nur.repos.etu.dmsShellPlugins.lyricsOnPanel
    ];
  };
}
