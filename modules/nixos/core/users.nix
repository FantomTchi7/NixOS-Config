{ pkgs, ... }:
{
  programs.fish.enable = true;

  users.users.fantomtchi7 = {
    description = "FantomTchi7";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "kvm"
      "adbusers"
    ];
    shell = pkgs.fish;
  };
}