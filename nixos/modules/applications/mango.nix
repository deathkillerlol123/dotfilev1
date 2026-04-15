{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xev
    mangowc
    glibc
    wayland
    wayland-protocols
    libinput
    libdrm
    libxkbcommon
    pixman
    meson
    gcc
    ninja
    gnumake
    rustc
    cargo
    raylib
    libdisplay-info
    seatd
    pcre2
    python315
    pipx  
  ];
}