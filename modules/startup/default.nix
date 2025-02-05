{
  home.file.".profile".text = ''
    PATH="$PATH:$HOME/.local/bin"
    if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

    run () {
      pidof $1 || nohup "$@" > /dev/null 2>&1 &
    }

    run flare --gapplication-service
    run fractal --gapplication-service
    run gnome-clocks --gapplication-service
  '';
}
