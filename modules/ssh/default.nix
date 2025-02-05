{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "enable-ssh-service" ''
      sudo rc-update add sshd default
    '')
  ];
}
