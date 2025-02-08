{
  pkgs,
  ...
}:

{
  home.file = {
    ".config/zsh/p10k.zsh".source =
      "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    ".config/zsh/p10k-theme.zsh".source = ./p10k-theme.zsh;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "set-zsh-default" ''
      sudo sed -i 's|/bin/ash|/home/user/.nix-profile/bin/zsh|g' /etc/passwd
    '')
  ];

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "sudo"
        "systemd"
      ];
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      btrfs-compress = "sudo btrfs filesystem defrag -czstd -r -v";
      reboot-uefi = "sudo systemctl reboot --firmware-setup";
      ssh = "TERM=xterm-256color ssh";
    };

    initExtra = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
      [[ ! -f ~/.config/zsh/p10k-theme.zsh ]] || source ~/.config/zsh/p10k-theme.zsh
      unsetopt PROMPT_SP
    '';
  };
}
