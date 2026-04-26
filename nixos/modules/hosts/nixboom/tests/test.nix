{config,lib,pkgs,inputs,...};{
  environment.systemPackages = with pgs; [
    vim
  ];
}