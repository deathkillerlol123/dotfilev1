{self, ...}: {
  flake.nixosModules.nixboom = {
    lib,
    pkgs,
    inputs,
    ...
  }: let
    enabled = names:
      lib.genAttrs names (_: {
        enable = true;
      });
    imod = names: map (x: inputs.${x}.nixosModules.${x}) names;
    fmod = names: map (x: self.nixosModules.${x}) names;
  in {
    imports =
      fmod ["lime" "dragware" "gaming" "main"]
      ++ imod ["home-manager" "mango"];
    programs = enabled ["wshowkeys" "mango"];
    lime = {
      enable = true;
      params = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "8250.nr_uarts=1"];
    };
    environment.systemPackages = with pkgs; [
      ghostty
      wdisplays
      whatsapp-electron
      firefox
      awww
      waypaper
      pywal
      swaylock
      rofi
      bzmenu
      pwmenu
      copyq
      grim
      slurp
      swappy
      wl-clipboard
    ];
    system.stateVersion = "25.11";
  };
}
