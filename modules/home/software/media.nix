{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haruna
    photoqt
    playerctl
    lxqt.pavucontrol-qt
    spotify
  ];
}
