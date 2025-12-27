{
  imports = [
    ./common
  ];
  perSystem = {config, ...}: let
    inherit (config) llvm commonArgs src;
    name = "security_compat";
  in {
    packages.security_compat = config.llvm.stdenv.mkDerivation ({
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
  };
}
