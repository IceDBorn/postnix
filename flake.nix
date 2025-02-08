{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    calls-patch = {
      url = "git+https://gitea.knp.one/jim3692/calls-patch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nerivations = {
      url = "github:icedborn/nerivations";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      calls-patch,
      home-manager,
      nerivations,
      zen-browser,
      ...
    }:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    home-manager
    // {
      homeConfigurations."user" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          calls = calls-patch.packages.${system}.default;
          zen-browser = zen-browser.packages.${system}.default;
        };

        modules = [
          ./home.nix
          nerivations.nixosModules.default
        ];
      };
    };
}
