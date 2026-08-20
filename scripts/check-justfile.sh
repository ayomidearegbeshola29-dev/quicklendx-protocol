#!/usr/bin/env bash
# Validates the developer Justfile (issue #2187).
#
# Happy path : `just help` lists the available recipes (non-empty, mentions help).
# Failure mode: an unknown recipe exits non-zero.
#
# Exits 0 (success) if `just` is not installed so it is safe to run anywhere;
# the CI job installs `just` first so the real assertions always run there.
set -euo pipefail

if ! command -v just >/dev/null 2>&1; then
  echo "just is not installed; skipping Justfile checks."
  exit 0
fi

echo "== happy path: 'just help' lists recipes =="
out="$(just help)"
echo "${out}"
echo "${out}" | grep -q "help" || { echo "FAIL: 'help' recipe not listed"; exit 1; }

echo "== failure mode: unknown recipe exits non-zero =="
if just this-recipe-does-not-exist-xyz-2187; then
  echo "FAIL: unknown recipe should have failed"; exit 1
fi

echo "OK: Justfile help target behaves as expected."
