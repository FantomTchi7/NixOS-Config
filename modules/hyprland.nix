{ pkgs, ... }:

{
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

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    xdg-user-dirs
  ];
}
