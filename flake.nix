{
  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };

    # The shim is disabled by default for macOS SDK 12+
    # nixpkgs 24.11 is the last stable version which provides macOS 11 SDK
    nixpkgs.url = "github:NixOS/nixpkgs/24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    systems.url = "github:nix-systems/default-darwin";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (let
      systems = import inputs.systems;
      flakeModules.default = import ./nix/flake-module.nix;
    in {
      imports = [
        flakeModules.default
        flake-parts.flakeModules.partitions
      ];

      inherit systems;
      debug = true;

      partitionedAttrs = {
        apps = "dev";
        checks = "dev";
        devShells = "dev";
        formatter = "dev";
      };
      partitions.dev = {
        # directory containing inputs-only flake.nix
        extraInputsFlake = ./nix/dev;
        module = {
          imports = [./nix/dev];
        };
      };
      # this won't be exported
      perSystem = {config, ...}: {
        config.packages.default = config.packages.security_compat;
      };

      flake = {
        inherit flakeModules;
      };
    });
}
#

