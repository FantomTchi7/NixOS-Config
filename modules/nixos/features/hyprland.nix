{ pkgs, ... }:

{
  programs.uwsm.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  networking.firewall.allowedTCPPorts = [ 10578 ];
  networking.firewall.allowedUDPPorts = [ 10578 ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = "fantomtchi7";
      };
      default_session = initial_session;
    };
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  security.polkit.enable = true;
}