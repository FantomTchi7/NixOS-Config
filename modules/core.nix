{ pkgs, ... }:

{
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  services.udisks2.enable = true;

  networking.networkmanager.enable = true;

  programs.fish.enable = true; 

  users.users.fantomtchi7 = {
    description = "FantomTchi7";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
