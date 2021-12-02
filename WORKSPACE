workspace(
    name = "slamdev_rules_pkg",
)

load(":internal_deps.bzl", "rules_pkg_internal_deps")

rules_pkg_internal_deps()

load("//pkg:repositories.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

load("//pkg:go_deps.bzl", "rules_pkg_go_dependencies")

rules_pkg_go_dependencies()
