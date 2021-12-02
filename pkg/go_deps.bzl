load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

def rules_pkg_go_dependencies():
    """Pull in external Go packages needed by Go binaries in this repo.

    Pull in all dependencies needed to build the Go binaries in this
    repository. This function assumes the repositories imported by the macro
    'rules_pkg_dependencies' in //pkg:repositories.bzl have been imported
    already.
    """
    go_rules_dependencies()
    go_register_toolchains(version = "1.17.2")
