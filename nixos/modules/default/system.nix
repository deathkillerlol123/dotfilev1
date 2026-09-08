{
  flake.nixosModules.system = {pkgs, ...}: {
    environment.systemPackages = with pkgs;
      [os-prober efibootmgr]
      ++ [lix]
      ++ [curl zip git jujutsu gh]
      ++ [libnotify ntfs3g borgbackup bottom]
      ++ [zoxide fd]
      ++ [nix-search-tv fzf]
      ++ [emacs nixd alejandra]
      ++ [bat fetch];
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      maple-mono.NF
    ];
  };
}
