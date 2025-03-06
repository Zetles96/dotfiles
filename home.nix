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
  ];

  # Program Configurations
  programs = {
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
    };
    git = {
      enable = true;
      userName = "mln";
      userEmail = "90190656+Zetles96@users.noreply.github.com";
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