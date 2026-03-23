{ pkgs, lib , inputs, ...}:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      #systemd-boot.enable = true;
      grub = {
        enable = false;
        devices = ["nodev"];
       	efiSupport = true;
       	useOSProber = true;
       	theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
      };
      limine = {
        enable = true;
        style = {
          wallpapers = lib.filesystem.listFilesRecursive ../../themes/limine_wallpaper;        
          wallpaperStyle = "centered";
        };
        extraEntries = ''
          /Windows
            protocol: efi
            path: uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
        extraConfig = ''
          remember_last_entry: yes
          '';
      };
    };
  };
};
