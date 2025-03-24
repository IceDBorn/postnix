{
  pkgs,
  ...
}:

let
    pythonFile = builtins.toFile "script.py" ''
        ${builtins.readFile ./call-audio-handler.py}
    '';
in {
  home.packages = [
    (pkgs.writeShellScriptBin "call-audio-hander" ''
        export PATH=$PATH:${ lib.makeBinPath [ pkgs.python3 ] }

        python3 ${pythonFile}
    '')
  ];
}
