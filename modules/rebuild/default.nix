{
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      while [[ $# -gt 0 ]]; do
        case $1 in
          -u)
            update="-u"
            apkUpdate="sudo apk update ; sudo apk upgrade"
            shift
            ;;
          *)
            echo "Unknown arg $1" >/dev/stderr
            exit 1
            ;;
        esac
      done

      $apkUpdate
      nh home switch ~/.config/home-manager $update
    '')
  ];
}
