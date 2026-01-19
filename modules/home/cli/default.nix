{ ... }:
{
  programs.fish.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "FantomTchi7";
      user.email = "[EMAIL_REDACTED]";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}