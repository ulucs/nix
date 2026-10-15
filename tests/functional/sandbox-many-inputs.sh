#!/usr/bin/env bash

source common.sh

if [[ $(uname) != Darwin ]]; then skipTest "Need Darwin"; fi

# common/vars.sh disables the sandbox whenever we're in a Nix environment, but this test
# is about compiling the sandbox profile. Skip if we can't launch a sandbox
if ! sandbox-exec -p '(version 1)(allow default)' true 2> /dev/null; then
    skipTest "Cannot apply a sandbox profile, probably already in a sandbox"
fi
unset _NIX_TEST_NO_SANDBOX

# The sandbox profile lists every input path. The sandbox compiler limits the
# size of a profile, see https://github.com/NixOS/nix/issues/4119.
#
# The builder is bash from the system store, which isn't a store path as far as
# the test store is concerned, so it never becomes an input and we have to allow
# it explicitly. We allow only bash's own store path (its closure is just itself,
# and the builder only uses shell builtins) rather than all of /nix/store: with
# the latter, the test passes even without bucketing.
count=1000

out=$(nix-build --no-out-link ./sandbox-many-inputs.nix \
    --option sandbox true \
    --option extra-sandbox-paths "${bash%/bin/bash}" \
    --arg count "$count" \
    --argstr seed "$RANDOM" \
    -vvv)
