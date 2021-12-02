# Bazel rules for pkg

## Installation

Include this in your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "slamdev_rules_pkg",
    branch = "main",
    remote = "https://github.com/slamdev/rules_pkg.git",
)

load("@slamdev_rules_pkg//pkg:repositories.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()
```

> note, in case you don't have rules_go configured in the project
> you can use helper macro below

```starlark
load("@slamdev_rules_pkg//pkg:go_deps.bzl", "rules_pkg_go_dependencies")

rules_pkg_go_dependencies()
```
