"pkg_tar rule"

load("//pkg/private:providers.bzl", "ArchiveInfo")

_DOC = "Rule creates a tar achive from the provided sources."

_ATTRS = {
    "srcs": attr.label_list(
        doc = "Files to add to the archive.",
        allow_files = True,
    ),
    "package_dir": attr.string(
        doc = "An absolute path to use as a prefix for all files in the tar.",
        default = "/",
    ),
    "_archiver": attr.label(
        default = Label("//pkg/private/rules:archiver"),
        cfg = "host",
        executable = True,
        allow_files = True,
    ),
}

def _impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".tar")
    size = ctx.actions.declare_file(ctx.label.name + ".size.txt")
    args = ctx.actions.args()
    args.add(out, format = "--out=%s")
    args.add(size, format = "--size-info=%s")
    args.add(ctx.attr.package_dir, format = "--dir=%s")
    args.add_all(ctx.files.srcs, format_each = "--file=%s", uniquify = True)
    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [out, size],
        arguments = [args],
        executable = ctx.executable._archiver,
        mnemonic = "Tar",
        progress_message = "Archiving %{output}",
    )
    return [
        DefaultInfo(
            files = depset([out]),
            runfiles = ctx.runfiles(files = [out]),
        ),
        ArchiveInfo(
            size = size,
        ),
    ]

pkg_tar = rule(
    doc = _DOC,
    implementation = _impl,
    attrs = _ATTRS,
    provides = [DefaultInfo, ArchiveInfo],
)
