"file_size rule"

load("//pkg/private:providers.bzl", "ArchiveInfo")

_DOC = "Rule outputs archive size to stdout."

_ATTRS = {
    "file": attr.label(
        doc = "Archive to output size for.",
        providers = [ArchiveInfo],
        mandatory = True,
    ),
    "_windows_constraint": attr.label(
        default = Label("@platforms//os:windows"),
    ),
}

def _impl(ctx):
    size = ctx.attr.file[ArchiveInfo].size

    content = None
    ext = None
    if ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]):
        content = "type {}".format(size.short_path)
        ext = "bat"
    else:
        content = "cat {}".format(size.short_path)
        ext = "sh"

    executable = ctx.actions.declare_file("{}.{}".format(ctx.label.name, ext))

    ctx.actions.write(
        executable,
        content,
        is_executable = True,
    )

    return DefaultInfo(
        files = depset([size]),
        executable = executable,
        runfiles = ctx.runfiles([size]),
    )

file_size = rule(
    doc = _DOC,
    implementation = _impl,
    attrs = _ATTRS,
    provides = [DefaultInfo],
    executable = True,
)
