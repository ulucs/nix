---
synopsis: "New builtin `builtins.storePathNarHash`"
prs: []
---

`builtins.storePathNarHash` returns the NAR hash (in SRI format) of a store
path referenced via a string with opaque store-path context. This exposes
the same hash Nix already uses to derive store paths to the Nix language,
without having to shell out to `nix path-info`. It is allowed in pure
evaluation mode.
