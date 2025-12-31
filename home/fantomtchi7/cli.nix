{ ... }:
{
  programs.fish = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "FantomTchi7";
    userEmail = "[EMAIL_REDACTED]";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
