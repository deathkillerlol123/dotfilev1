{self, ... }: {
  flake.nixosModules.nixboom =  { lib,pkgs,inputs, ... }:
    let
      windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
      enabled =
        names:
        lib.genAttrs names (_: {
          enable = true;
        });
      imod = names: map (x: inputs.${x}.nixosModules.${x}) names;
      fmod = names: map (x: self.nixosModules.${x}) names;
    in
    {
      imports =
        fmod [ "gaming" "lime" "main" "dragware" ] ++
        imod [ "home-manager" "mango" ];
      lime = {
        enable = true;
        params = ["snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" ];
        windows.location = windows_efi;
      };
      programs = enabled [ "wshowkeys" "mango" ];
###      services.displayManager.ly.enable = true;
      environment.systemPackages = with pkgs; [
        wdisplays whatsapp-electron firefox
        (discord.override {
          withOpenASAR = true;
        })
        libreoffice awww  waypaper pywal swaylock rofi bzmenu pwmenu copyq
        grim slurp swappy wl-clipboard ghostty python312
      ];
      system.stateVersion = "25.11";
    };
}
