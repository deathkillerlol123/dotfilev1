{...}: {
  flake.homeModules.nbghostty = {...}: {
    programs.ghostty = {
      enable = true;
      settings = {
        config-file = "~/dotfiles/nixos/modules/hosts/users/nixboom/home/.config/ghostty/ghostty.conf";
        app-notifications = false;
        font-family = "Maple Mono NF";
        font-size = 14;
        cursor-style = "block";
        shell-integration = "fish";
        confirm-close-surface = false;
        copy-on-select = "clipboard";
        clipboard-read = "allow";
        clipboard-write = "allow";
        background-opacity = 0.85;
      };
      keybindings = {
        "ctrl+shift+%" = "new_split:right";
        "ctrl+shift+s" = "new_split:down";
        "ctrl+tab" = "goto_split:next";
      };
    };
  };
}
