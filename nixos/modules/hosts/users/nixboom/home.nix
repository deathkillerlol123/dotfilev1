{self, ...}: {
  flake.homeModules.nixboom = {config, ...}: let
    user = "nixboom";
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/modules/hosts/users/${user}/home";
  in {
    imports = with self.homeModules; [nbpackages nbcustom_scripts nbgtk nbgit nbdesktop nbmango nbfirefox nbstarship nbfish nbnu nbghostty];
    home = {
      file = {
        ".emacs".source = "${dotfiles}/.emacs";
        ".config/rofi".source = "${dotfiles}/.config/rofi";
      };
    };
  };
}
