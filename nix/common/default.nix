{lib, ...}: {
  perSystem = {pkgs, ...}: let
    llvm = pkgs.llvmPackages_latest;
    inherit (pkgs) darwinMinVersionHook;
  in {
    options = {
      llvm = lib.mkOption {
        default = llvm;
      };
      commonArgs = lib.mkOption {
        type = lib.types.attrs;
        default = {
          buildInputs = with pkgs; [
            apple-sdk_11
            (darwinMinVersionHook "10.14")
          ];
          nativeBuildInputs = with llvm; [
            bintools
            clang
          ];
          # hardeningDisable = ["all"];
          NIX_ENFORCE_NO_NATIVE = 0;
        };
      };
    };
  };
}
