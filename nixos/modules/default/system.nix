{
  flake.nixosModules.system = {pkgs, ...}: {
    environment.systemPackages = with pkgs;
      [os-prober efibootmgr]
      ++ [lix]
      ++ [zip git jujutsu gh]
      ++ [ntfs3g borgbackup bottom]
      ++ [zoxide nix-search-tv fzf]
      ++ [nixd alejandra deadnix]
      ++ [bat];
    fonts.packages = with pkgs; [nerd-fonts.fira-code maple-mono.NF];
  };
}
