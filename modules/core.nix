{ pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  services.udisks2.enable = true;

  networking.networkmanager.enable = true;

  users.users.fantomtchi7 = {
    description = "FantomTchi7";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
