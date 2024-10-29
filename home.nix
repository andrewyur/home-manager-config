{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
      "direnv"
    ];
    theme = "robbyrussell";
  };

  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.username = "home";
  home.homeDirectory = "/Users/home";

  home.packages = [
    pkgs.git
  ];

  home.file = {
    # this will probably change pretty frequently, i need to make sure to update it
    ".config/zed/settings.json".text = ''
    {
      "ui_font_size": 16,
      "buffer_font_size": 12,
      "theme": {
        "mode": "system",
        "light": "Rosé Pine Dawn",
        "dark": "One Dark"
      },
      "terminal": {
        "working_directory": "current_project_directory"
      }
    }
    '';
    ".config/1password/ssh/agent.toml".text = ''
        [[ssh-keys]]
        vault = "Andy's Cool Stuff"
    ''
  };

  home.sessionVariables = {
    EDITOR = "zed";

    # Direnv log formatting
    # DIRENV_LOG_FORMAT="$'\033[2mdirenv: %s\033[0m'";
    DIRENV_LOG_FORMAT="";

    # 1password ssh agent
    SSH_AUTH_SOCK="~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };

  # DONT CHANGE
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
