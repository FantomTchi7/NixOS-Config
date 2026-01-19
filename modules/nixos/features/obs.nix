{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
        ffmpeg = pkgs.ffmpeg-full.override { withUnfree = true; };
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };
}