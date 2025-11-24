hyprctl keyword general:layout "$(hyprctl getoption general:layout | grep -q 'dwindle' && echo 'master' || echo 'dwindle')" #! @description: "Toggle between dwindle and master layout"; @windows;
