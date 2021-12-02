_DOC = "ArchiveInfo provider is exported by pkg_tar rule."

_FIELDS = {
    "size": "a file with archive size data",
}

ArchiveInfo = provider(
    doc = _DOC,
    fields = _FIELDS,
)
