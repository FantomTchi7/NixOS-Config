{ pkgs, ... }:
{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    vesktop
    teamspeak3
    qbittorrent
  ];
}
