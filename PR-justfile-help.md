# Add a `just` help target to the developer task runner

Resolves **QuickLendX/quicklendx-protocol#2187** (GrantFox OSS / Official Campaign | FWC26).

## Summary

The repo had no `just` task runner, so contributors had no single, self-documenting entry point for common developer commands. This PR adds a `Justfile` whose **`help` target** (also the default) prints every available recipe, plus a small set of convenience recipes that map to the existing `cargo` commands the repo already uses.

This keeps the tool set small: the only new dependency is `just` itself, and every recipe is an idempotent wrapper over a command contributors already run.

## What changed

- **`Justfile`** (new)
  - `help` (and `default`) recipe prints the recipe list via `just --list`.
  - `build`, `test`, `clippy`, `fmt-check`, `build-wasm` — thin, re-runnable wrappers over the standard cargo invocations used across this Soroban workspace.
- **`scripts/check-justfile.sh`** (new) — the test for the new behaviour:
  - *Happy path:* `just help` lists recipes (output is non-empty and mentions `help`).
  - *Failure mode:* an unknown recipe exits non-zero (the script asserts the failure).
  - Exits 0 if `just` isn't installed, so it's safe to run anywhere.
- **`.github/workflows/justfile.yml`** (new) — installs `just` and runs `scripts/check-justfile.sh` on every change to `Justfile` / the check script, so the DX contract can't silently regress.
- **`README.md`** — added a "Developer tooling" section documenting `just`, `just help`, and the available recipes.

## Acceptance criteria (from #2187)

- [x] The change matches the summary (add a `justfile` help target).
- [x] Tests cover the new behavior — happy path (`just help` lists recipes) + one explicit failure mode (unknown recipe fails), wired through CI.
- [x] Lint/type-check/tests relevant to the change pass (`bash scripts/check-justfile.sh` passes locally).
- [x] PR description references this issue with `Closes #2187`.

## Test plan

```bash
just            # lists recipes (default == help)
just help       # same
bash scripts/check-justfile.sh
```

Closes #2187.
