# Home Manager configuration for user-specific settings

{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  # User Packages
  home.packages = with pkgs; [
    neovim
    kdePackages.kate
    vscode
    wireshark
    teamviewer
    rdesktop
    starship
  ];

  # Program Configurations
  programs = {
    ghostty = {
      enable = true;

      settings = {
        font-family = "JetBrains Mono";
        font-size = 12;
      };
    };
    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#mlnnix";
      };
      history = {
        size = 10000;
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        share = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "docker" "kubectl" ];
      };
      initExtra = ''
        eval "$(starship init zsh)"
      '';
    };
    git = {
      enable = true;
      userName = "mln";
      userEmail = "90190656+Zetles96@users.noreply.github.com";
      extraConfig = {
        push.autoSetupRemote = true;
      };
    };
    starship = {
      enable = true;
      enableTransience = true;
      settings = {
        # General settings
        add_newline = true;
        scan_timeout = 10;
        format = "$username$hostname$directory$git_branch$git_status$docker_context$rust$python$c_cpp$nodejs$golang$nix_shell$cmd_duration$time\n$character";

        # Tokyo Night color palette
        palette = "tokyo_night";
        palettes.tokyo_night = {
          bg = "#1a1b26";      # Dark blue-gray background
          fg = "#c0caf5";      # Light foreground text
          purple = "#9d7cd8";  # Purple for Git, etc.
          blue = "#7aa2f7";    # Blue for directories
          teal = "#7dcfff";    # Teal for symbols
          pink = "#bb9af7";    # Pink for errors
          gray = "#565f89";    # Muted gray for secondary info
          green = "#9ece6a";   # Green for success
        };
        # Transient prompt (shown after command execution)
        # transient = {
        #   format = "[$character]($style) "; # Simple prompt with just the character
        # };

        # Character (prompt symbol)
        character = {
          success_symbol = "[❯](teal)";
          error_symbol = "[❯](pink)";
          vicmd_symbol = "[❮](green)"; # For vi-mode in Zsh
        };

        # Username
        username = {
          style_user = "fg bold";
          style_root = "pink bold";
          format = "[$user]($style)@";
          show_always = false;
        };

        # Hostname
        hostname = {
          ssh_only = true;
          style = "purple";
          format = "[$hostname]($style):";
        };

        # Directory
        directory = {
          style = "blue";
          truncation_length = 3;
          truncate_to_repo = true;
          format = "[$path]($style) ";
          substitutions = {
            "Documents" = "󰈙";
            "Downloads" = "";
            "Music" = "";
            "Pictures" = "";
          };
        };

        # Git Branch
        git_branch = {
          symbol = " ";
          style = "purple bold";
          format = "[$symbol$branch]($style) ";
        };

        # Git Status
        git_status = {
          style = "gray";
          format = "[$all_status$ahead_behind]($style) ";
        };

        # Docker Context
        docker_context = {
          symbol = "🐳 ";
          style = "teal";
          format = "[$symbol$context]($style) ";
        };

        # Rust
        rust = {
          symbol = "🦀 ";
          style = "purple";
          format = "[$symbol$version]($style) ";
        };

        # Python
        python = {
          symbol = "🐍 ";
          style = "blue";
          format = "[$symbol$pyenv_prefix$version]($style) ";
        };

        # C/C++
        c = {
          symbol = " ";
          style = "purple";
          format = "[$symbol$version]($style) ";
        };

        # JavaScript/Node.js
        nodejs = {
          symbol = " ";
          style = "green";
          format = "[$symbol$version]($style) ";
        };

        # Go
        golang = {
          symbol = " ";
          style = "blue";
          format = "[$symbol$version]($style) ";
        };

        nix_shell = {
          symbol = "❄️ ";
          style = "teal";
          format = "[$symbol$state]($style) ";
          impure_msg = "impure";
          pure_msg = "pure";
        };

        # Command Duration
        cmd_duration = {
          min_time = 2000; # Show if command takes >2s
          style = "gray";
          format = "took [$duration]($style) ";
        };
        time = {
          disabled = false;
          format = "[  $time]($style) ";
          style = "gray";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
        };
      };
    };
  };

  # Dconf Settings
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}