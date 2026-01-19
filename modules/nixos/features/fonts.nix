{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}