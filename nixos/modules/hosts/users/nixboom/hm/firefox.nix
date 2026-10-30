{inputs, ...}: {
  flake.homeModules.nbfirefox = {config, ...}: let
    firefox_user = "declaritive";
    fire-addons = inputs.firefox-addons.packages."x86_64-linux";
  in {
    programs = {
      firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisplayBookmarksToolBar = "never";
        };
        profiles = {
          ${firefox_user} = {
            settings = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "devtools.chrome.enabled" = true;
              "devtools.debugger.remote-enabled" = true;
              "browser.startup.homepage" = "https://search.nixos.org/packages";
              "browser.ml.chat.enabled" = false;
              "browser.ml.enable" = false;
              "browser.urlbar.suggest.searches" = false;
              "browser.tabs.groups.smart.enabled" = false;
              "extensions.pocket.enabled" = false;
              "privacy.trackingprotection.enabled" = true;
              "general.autoScroll" = true;
              "media.hardwaremediakeys.enabled" = true;
              "sidebar.revamp" = false;
              "network.prefetch-next" = false;
            };
            userChrome = ''
              #TabsToolbar {
                  visibility: collapse !important;
                  height: 0 !important;
                  min-height: 0 !important;
                  max-height: 0 !important;
               }
            '';
            extensions.packages = [
              fire-addons.bitwarden
              fire-addons.ublock-origin
              fire-addons.sidebery
              fire-addons.darkreader
            ];
          };
        };
      };
    };
  };
}
