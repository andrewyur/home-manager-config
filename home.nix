{ config, userConfig, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            hmb = "home-manager switch -b backup";
            wjl = "watch -c 'jj log --color=always'";
        };
    };
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
    programs.zoxide.enable = true;

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    home.username = userConfig.username;
    home.homeDirectory = userConfig.homeDirectory;

    home.packages = [
        # version control
        pkgs.git
        pkgs.jujutsu

        # utilities
        pkgs.watch
        pkgs.tmux

        # fonts
        pkgs.jetbrains-mono

        # nix language server
        pkgs.nixd
    ];

    home.file = {
        ".config/1password/ssh/agent.toml".text = ''
            [[ssh-keys]]
            vault = "Andy's Cool Stuff"
        '';
        ".gitconfig".text = ''
        [push]
       	autoSetupRemote = true
        [user]
       	name = Andrew Yurovchak
       	email = andy@yurovchak.net
        '';
        ".jjconfig.toml".text = ''
        [user]
        name = "Andrew Yurovchak"
        email = "andy@yurovchak.net"
        '';
        ".config/zed/settings.json".text = ''
        {
            "ui_font_size": 16,
            "buffer_font_size": 12,
            "theme": {
                "mode": "system",
                "light": "Rosé Pine Dawn",
                "dark": "One Dark"
            },
            "format_on_save": "on",
            "languages": {
                "Nix": {
                "format_on_save": "off"
                }
            },
            "buffer_font_family": "JetBrains Mono",
            "load_direnv": "shell_hook",
            "soft_wrap": "editor_width",
            "terminal": {
                "working_directory": "current_project_directory"
            }
        }
        '';
        ".tmux.conf".text = ''
        set-option -g default-shell ~/.nix-profile/bin/zsh
        '';
    };

    home.sessionVariables = {
        # editing commits is easier with a cli editor
        EDITOR = "nano";

        # Direnv log formatting
        # DIRENV_LOG_FORMAT="$'\033[2mdirenv: %s\033[0m'";
        DIRENV_LOG_FORMAT="";

        # 1password ssh agent
        SSH_AUTH_SOCK="${userConfig.homeDirectory}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    # DONT CHANGE
    home.stateVersion = "24.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
