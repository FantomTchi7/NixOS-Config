{ ... }:
{
  programs.fish = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "FantomTchi7";
    userEmail = "vladislav.kudriashev@gmail.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
