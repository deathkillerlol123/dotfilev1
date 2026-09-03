{self, ...}: {
  flake.homeModules.nixboom = {config, ...}: let
    user = "nixboom";
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/modules/hosts/users/${user}/home";
  in {
    imports = with self.homeModules; [packages custom_scripts nbgtk nbgit nbdesktop nbmango nbfirefox nbdiscord nbstarship nbfish nbnu];
    programs.home-manager.enable = true;
    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "25.11";
      file = {
        ".emacs".source = "${dotfiles}/.emacs";
        ".config/rofi".source = "${dotfiles}/.config/rofi";
        ".config/ghostty".source = "${dotfiles}/.config/ghostty";
      };
    };
  };
}
