{
  imports = [
    ./common
  ];
  perSystem = {
    config,
    pkgs-unstable,
    ...
  }: let
    inherit (config) commonArgs src toolchain;
    inherit (pkgs-unstable.lib) replaceString;
    name = "sectrust-compat";
  in {
    config = {
      packages = {
        "${name}" = toolchain.llvm.stdenv.mkDerivation ({
            inherit name;
            inherit src;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/lib
              cp lib${replaceString "-" "_" name}.dylib $out/lib

              runHook postBuild
            '';
          }
          // config.commonArgs);

        hello-bigsur =
          toolchain.buildGo125Module {
            name = "hello-bigsur";
            inherit src;
            modRoot = "./examples/hello-bigsur";
            vendorHash = "sha256-/ian8Wgg1aT/XmKXKa4InwlmhRfL0qIriPTPqMoveg0=";

            env.CGO_ENABLED = 1;
          }
          // config.commonArgs;
      };
    };
  };
}
