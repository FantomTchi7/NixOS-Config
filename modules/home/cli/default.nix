{ config, pkgs, ... }:
{
  sops.secrets.git_email = { };

  sops.templates."git-config".content = ''
    [user]
    email = ${config.sops.placeholder.git_email}
  '';

  programs.fish.enable = true;

  programs.git = {
    enable = true;
    includes = [
      { path = config.sops.templates."git-config".path; }
    ];
    settings = {
      user.name = "FantomTchi7";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}