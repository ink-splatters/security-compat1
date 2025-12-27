{
  perSystem = {pkgs, ...}: {
    formatter = pkgs.writeShellScriptBin "fmt-all" ''
      ${pkgs.alejandra}/bin/alejandra .

      echo "Formatting markdown files..."
      ${pkgs.fd}/bin/fd '\.md$' -x ${pkgs.mdformat}/bin/mdformat
    '';
  };
}
