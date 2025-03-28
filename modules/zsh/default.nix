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
      sudo sed -i 's|/bin/ash|/home/icedborn/.nix-profile/bin/zsh|g' /etc/passwd
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
    shellAliases.ssh = "TERM=xterm-256color ssh";

    initExtra = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
      [[ ! -f ~/.config/zsh/p10k-theme.zsh ]] || source ~/.config/zsh/p10k-theme.zsh
      unsetopt PROMPT_SP

      PATH="$PATH:$HOME/.local/bin"
      if [ -e /home/icedborn/.nix-profile/etc/profile.d/nix.sh ]; then . /home/icedborn/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
  };
}
