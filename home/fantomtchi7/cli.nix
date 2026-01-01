{ ... }:
{
  programs.fish = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "FantomTchi7";
      user.email = "vladislav.kudriashev@gmail.com";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
