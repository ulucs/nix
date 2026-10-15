{ count, seed }:

with import ./config.nix;

let
  # Each input is a distinct store path that ends up in the sandbox profile.
  # Directories are added as (subpath ...) filters, like most real inputs.
  inputs = builtins.genList (
    i:
    builtins.path {
      path = ./.;
      filter = _: _: false;
      name = "input-${seed}-${toString i}";
    }
  ) count;
in

mkDerivation {
  name = "sandbox-many-inputs";
  # The list of paths is too large for the environment.
  passAsFile = [ "inputs" ];
  inputs = builtins.concatStringsSep "" (map (p: p + "\n") inputs);
  buildCommand = "echo '' > $out";
}
