"# PKG Rules"

load("//pkg/private/rules:pkg_tar.bzl", _pkg_tar = "pkg_tar")
load("//pkg/private/rules:file_size.bzl", _file_size = "file_size")
load("//pkg/private:providers.bzl", _ArchiveInfo = "ArchiveInfo")

pkg_tar = _pkg_tar
file_size = _file_size
ArchiveInfo = _ArchiveInfo
