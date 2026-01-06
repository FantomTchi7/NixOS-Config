{ pkgs, inputs, ... }:

{
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
  boot.zfs.package = pkgs.cachyosKernels.zfs-cachyos;

  services.scx = {
    enable = true;
    scheduler = "scx_cosmos";
    extraArgs = [
      "-c" "0"
      "-p" "0"
    ];
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/fantomtchi7/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
  ];
}
