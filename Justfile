# QuickLendX developer task runner.
#
# Run `just` or `just help` to list every available recipe. Every recipe maps
# to an existing cargo/npm command so the tool set stays small (no new global
# CLI dependencies beyond `just` itself) and each recipe is safe to re-run.

# List all available recipes (default when `just` is run with no arguments).
default:
    @just --list

# Print a short overview of the developer recipes in this Justfile.
help:
    @just --list

# Build every workspace crate.
build:
    cargo build --workspace

# Run the full workspace test suite.
test:
    cargo test --workspace

# Lint with clippy across the workspace, denying warnings.
clippy:
    cargo clippy --workspace --all-targets -- -D warnings

# Verify formatting without modifying files.
fmt-check:
    cargo fmt --all -- --check

# Build the Soroban contract target for WASM.
build-wasm:
    cargo build --target wasm32-unknown-unknown --release
