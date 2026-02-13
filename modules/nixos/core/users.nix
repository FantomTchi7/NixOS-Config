{ config, pkgs, ... }:
{
  programs.fish.enable = true;

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = [ "/home/fantomtchi7/.ssh/id_ed25519" ];
  
  sops.secrets.user_password.neededForUsers = true;

  users.users.fantomtchi7 = {
    description = "FantomTchi7";
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user_password.path;
    extraGroups = [
      "wheel"
      "docker"
      "kvm"
      "adbusers"
    ];
    shell = pkgs.fish;
  };
}
