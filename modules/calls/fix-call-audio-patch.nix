final: super: {
  calls = super.calls.overrideAttrs (
    finalAttrs: superAttrs: {
      patches = [
        ./patch.nix
      ];

      doCheck = false;
      doInstallCheck = false;
    }
  );
}
