{ ... }:
{
  imports = [
    ./networking.nix
    ./users.nix
    ./nix.nix
  ];

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";
}