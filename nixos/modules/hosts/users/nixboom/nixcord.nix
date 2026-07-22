{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  flake.homeModules.discord = {
    config,
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nixcord.homeModules.nixcord];
    programs = {
      nixcord = {
        enable = true;
        discord = {
          vencord.enable = true;
          krisp.enable = true;
        };
        config = {
          useQuickCss = true;
          autoUpdateNotification = true;
          notifyAboutUpdates = true;
          themeLinks = [
            "https://raw.githubusercontent.com/refact0r/midnight-discord/0c6e4b5009df5f13fe33d9b279378378d5212330/themes/midnight.theme.css"
          ];
          plugins = {
            autoDndWhilePlaying.statusToSet = "dnd";
            fakeNitro = {
              enableStreamQualityBypass = true;
            };
            typingTweaks = {
              showAvatars = true;
            };
          };
          frameless = true;
        };
      };
    };
  };
}
