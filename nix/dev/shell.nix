{
  perSystem = {
    config,
    pkgs,
    ...
  }: let
    inherit (config) pre-commit;
  in {
    devShells.default = pkgs.mkShell.override {inherit (config.llvm) stdenv;} ({
        packages = pre-commit.settings.enabledPackages;
      }
      // config.commonArgs);
  };
}
