{self, ... }: {
  flake.nixosModules.nixboom =  { lib,pkgs, ... }:
    let
      windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
      enabled =
        names:
        lib.genAttrs names (_: {
          enable = true;
        });
    in
    {
      imports = with self.nixosModules; [ uxplay gaming lime windows main dragware];
      lime = {
        enable = true;
        params = ["snd_hda_intel.dmic_detect=0"   "snd_intel_dspcfg.dsp_driver=1" ];
        windows.location = windows_efi;
      };
      programs = enabled [ "wshowkeys" "mangowc" ];
      services.displayManager.ly.enable = true;
      environment.systemPackages = with pkgs; [
        wdisplays firefox-devedition whatsapp-electron
        (discord.override {
          withOpenASAR = true;
        })
        libreoffice
        swww pywal swaynotificationcenter swaylock rofi
        bzmenu pwmenu copyq grim slurp swappy wl-clipboard
        wezterm python312 kdePackages.kdeconnect-kde
      ];
      system.stateVersion = "25.11";
    };
}
