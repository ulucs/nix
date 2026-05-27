let
  p = builtins.toFile "hello" "hello\n";
in
builtins.storePathNarHash p
