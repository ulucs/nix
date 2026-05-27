let
  drv = derivation {
    name = "fail";
    builder = "/bin/false";
    system = "x86_64-linux";
  };
in
builtins.storePathNarHash drv.outPath
