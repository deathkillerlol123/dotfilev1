{self, ... }:
let
  windows_efi = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
in
{
  flake.nixosModules.nixboom =  { pkgs, ... }: {
      imports = with self.nixosModules; [ uxplay gaming fish windows main dragware lime ];
      lime = {
        enable = true;
        params = ["snd_hda_intel.dmic_detect=0"   "snd_intel_dspcfg.dsp_driver=1" "random.trust_cpu=on"];
        windows.location = windows_efi;
      };
      boot.loader.timeout = 0;
      virtualisation.libvirtd = {
        enable = true;
        onBoot = "ignore";
        onShutdown = "shutdown";
      };
      programs.mangowc.enable = true;
      services.displayManager.ly.enable = true;
      networking.firewall = {
        allowedTCPPorts = [ 6642   443 ];
        allowedUDPPorts = [ 6642   443 ];
      };
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
