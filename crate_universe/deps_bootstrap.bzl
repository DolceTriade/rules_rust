"""A module is used to assist in bootstrapping cargo-bazel"""

load("//cargo:defs.bzl", "cargo_bootstrap_repository")
load("//crate_universe/private:srcs.bzl", "CARGO_BAZEL_SRCS")

# buildifier: disable=bzl-visibility
load("//rust/private:common.bzl", "rust_common")

def cargo_bazel_bootstrap(
        name = "cargo_bazel_bootstrap",
        rust_version = rust_common.default_version,
        rust_toolchain_cargo_template = "@rust_{system}_{arch}//:bin/{tool}",
        rust_toolchain_rustc_template = "@rust_{system}_{arch}//:bin/{tool}",
    ):
    """An optional repository which bootstraps `cargo-bazel` for use with `crates_repository`

    Args:
        name (str, optional): The name of the `cargo_bootstrap_repository`.
        rust_version (str, optional): The rust version to use. Defaults to the default of `cargo_bootstrap_repository`.
        rust_toolchain_cargo_template (str, optional): The template to use for finding the host `cargo` binary.
        rust_toolchain_rustc_template (str, optional): The template to use for finding the host `rustc` binary.
    """
    cargo_bootstrap_repository(
        name = name,
        srcs = CARGO_BAZEL_SRCS,
        binary = "cargo-bazel",
        cargo_lockfile = "@rules_rust//crate_universe:Cargo.lock",
        cargo_toml = "@rules_rust//crate_universe:Cargo.toml",
        version = rust_version,
        # The increased timeout helps avoid flakes in CI
        timeout = 900,
        rust_toolchain_cargo_template = rust_toolchain_cargo_template,
        rust_toolchain_rustc_template = rust_toolchain_rustc_template,
    )
