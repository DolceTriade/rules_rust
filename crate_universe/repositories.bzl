"""A module defining dependencies of the `cargo-bazel` Rust target"""

load("@rules_rust//rust:defs.bzl", "rust_common")
load("//crate_universe:deps_bootstrap.bzl", "cargo_bazel_bootstrap")
load("//crate_universe/3rdparty:third_party_deps.bzl", "third_party_deps")
load("//crate_universe/3rdparty/crates:crates.bzl", _vendor_crate_repositories = "crate_repositories")
load("//crate_universe/private:vendor_utils.bzl", "crates_vendor_deps")
load("//crate_universe/tools/cross_installer:cross_installer_deps.bzl", "cross_installer_deps")

def crate_universe_dependencies(
        rust_version = rust_common.default_version,
        bootstrap = False,
        rust_toolchain_cargo_template = "@rust_{system}_{arch}//:bin/{tool}",
        rust_toolchain_rustc_template = "@rust_{system}_{arch}//:bin/{tool}",
):
    """Define dependencies of the `cargo-bazel` Rust target

    Args:
        rust_version (str, optional): The version of rust to use when generating dependencies.
        bootstrap (bool, optional): If true, a `cargo_bootstrap_repository` target will be generated.
        rust_toolchain_cargo_template (str, optional): The template to use for finding the host `cargo` binary.
        rust_toolchain_rustc_template (str, optional): The template to use for finding the host `rustc` binary.
    """
    third_party_deps()

    if bootstrap:
        cargo_bazel_bootstrap(
            rust_version = rust_version,
            rust_toolchain_cargo_template = rust_toolchain_cargo_template,
            rust_toolchain_rustc_template = rust_toolchain_rustc_template,
        )

    _vendor_crate_repositories()

    crates_vendor_deps()
    cross_installer_deps()
