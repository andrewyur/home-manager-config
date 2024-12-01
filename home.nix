{ config, userConfig, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            hmb = "home-manager switch -b backup";
            wjl = "watch -c 'jj log --color=always --ignore-working-copy'";
            pfr = "pip freeze > requirements.txt";
            cf = "echo '${builtins.readFile ./flake_template.nix}' > flake.nix";
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

    programs.fzf = {
        enable = true;
        defaultCommand = "rg --files --hidden ~";
        fileWidgetCommand = "rg --files --hidden ~";
    };
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
        pkgs.ripgrep

        # fonts
        pkgs.jetbrains-mono

        # nix language server
        pkgs.nixd
    ];

    home.file = {
        # 1password ssh agent
        ".config/1password/ssh/agent.toml".text = ''
            [[ssh-keys]]
            vault = "Andy's Cool Stuff"
        '';
        # git config
        ".gitconfig".text = ''
        [push]
       	autoSetupRemote = true
        [user]
       	name = Andrew Yurovchak
       	email = andy@yurovchak.net
        '';
        # jj config
        ".jjconfig.toml".text = ''
        [user]
        name = "Andrew Yurovchak"
        email = "andy@yurovchak.net"
        '';
        # tmux config
        ".tmux.conf".text = ''
        set-option -g default-shell ~/.nix-profile/bin/zsh
        '';
        # ignore file for fzf
        ".ignore".text = ''
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
