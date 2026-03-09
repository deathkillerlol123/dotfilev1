{
  pkgs,
  config,
  ...
}: {
  # sddm-astronaut-theme
  services.displayManager.sddm = {
    enable = false;
    theme = "sddm-astronaut-theme"; # Must match package name
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];
  };

  environment.systemPackages = with pkgs; [
    #would be pkgs.packagename without the with pkgs;
    (pkgs.callPackage ../../../ressources/sddm-astronaut-theme {
      # theme = "hyprland_kath";
      theme = "black_hole";
      # theme = "japanese_aesthetic";
      # theme = "astronaut";
      # theme = "purple_leaves";
      # theme = "pixel_sakura(-static)";
      themeConfig = {
        General = {
          HeaderText = "Hi First try";
          # Background = "/home/maike/.config/nixos/ressources/wallpapers/1359465.png";
          Background = "${config.stylix.image}";
          FullBlur = "false";
        };
        Colors = {
          HeaderTextColor = "#${config.lib.stylix.colors.base05}";
          BackgroundColor = "#fde086";
          DimBackgroundColor = "#fde086";
          LoginFieldBackgroundColor = "#fde086";
          PasswordFieldBackgroundColor = "#fde086";
          HighlightBackgroundColor = "#fde086";
        };
      };
    })
  ];
}
