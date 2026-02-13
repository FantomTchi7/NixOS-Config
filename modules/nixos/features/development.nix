{ pkgs, ... }:

{
  programs.partition-manager.enable = true;

  environment.systemPackages = with pkgs; [
    e2fsprogs
  ];
}
