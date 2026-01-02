{ pkgs, config, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  programs.uwsm.enable = true;

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

  security.polkit.enable = true;
}
