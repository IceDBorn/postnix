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
            apkUpdate="sudo sh -c 'apk update && apk upgrade'"
            shift
            ;;
          *)
            echo "Unknown arg $1" >/dev/stderr
            exit 1
            ;;
        esac
      done

      sh -c "$apkUpdate"
      nh home switch ~/.config/home-manager $update
    '')
  ];
}
