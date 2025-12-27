{inputs, ...}: {
  imports = [
    ./common
  ];
  perSystem = {
    config,
    system,
    pkgs-unstable,
    ...
  }: let
    inherit (config) llvm commonArgs src;
    name = "security_compat";
  in {
    config = {
      _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
      };
      packages = {
        security_compat = config.llvm.stdenv.mkDerivation ({
            inherit name;
            src = ../.;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/lib
              cp lib${name}.dylib $out/lib

              runHook postBuild
            '';
          }
          // config.commonArgs);

        demo = pkgs-unstable.buildGoModule {
          name = "demo";
          src = ../demo;
          vendorHash = "sha256-Fa0Mcl+crWB8F5rJXXsBFZA6erxh2OhoAsNDl2xscO0=";
        };
      };
    };
  };
}
