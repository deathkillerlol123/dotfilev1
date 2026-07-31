{
  flake.nixosModules.system = {pkgs, ...}: {
    environment.systemPackages = with pkgs;
      [os-prober efibootmgr]
      ++ [curl zip git jujutsu gh]
      ++ [libnotify ntfs3g borgbackup bottom]
      ++ [zoxide fd]
      ++ [nix-search-tv fzf]
      ++ [emacs nixd alejandra]
      ++ [eza bat fastfetch];
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      maple-mono.NF
    ];
  };
}
