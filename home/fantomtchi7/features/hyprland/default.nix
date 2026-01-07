{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  xdg.configFile."uwsm/env-hyprland".text = ''
    export AQ_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
  '';

  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
    };

    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  programs.firefox.enable = true;

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.vscodeintellicode-csharp
      ms-dotnettools.vscode-dotnet-runtime
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      ms-python.vscode-pylance
      ms-python.python
      ms-python.pylint
    ];
  };
  home.sessionVariables.EDITOR = "codium --wait";


  home.packages = with pkgs; [
    hyprpolkitagent
    xdg-user-dirs
    kdePackages.dolphin
    kdePackages.qt6ct
    nwg-look
    fooyin
    photoqt
    haruna
    ghostty
    legcord
    spotify
    blender
    gimp
    inkscape
  ];
}
