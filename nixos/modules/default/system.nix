{
  flake.nixosModules.system = {
    inputs,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs;
      [os-prober efibootmgr]
      ++ [inputs.nixpkgs-pinned.legacyPackages.${pkgs.system}.lix]
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
