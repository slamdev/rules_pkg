<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# PKG Rules

<a id="#file_size"></a>

## file_size

<pre>
file_size(<a href="#file_size-name">name</a>, <a href="#file_size-file">file</a>)
</pre>

Rule outputs archive size to stdout.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="file_size-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="file_size-file"></a>file |  Archive to output size for.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#pkg_tar"></a>

## pkg_tar

<pre>
pkg_tar(<a href="#pkg_tar-name">name</a>, <a href="#pkg_tar-package_dir">package_dir</a>, <a href="#pkg_tar-srcs">srcs</a>)
</pre>

Rule creates a tar achive from the provided sources.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="pkg_tar-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="pkg_tar-package_dir"></a>package_dir |  An absolute path to use as a prefix for all files in the tar.   | String | optional | "/" |
| <a id="pkg_tar-srcs"></a>srcs |  Files to add to the archive.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#ArchiveInfo"></a>

## ArchiveInfo

<pre>
ArchiveInfo(<a href="#ArchiveInfo-size">size</a>)
</pre>

ArchiveInfo provider is exported by pkg_tar rule.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="ArchiveInfo-size"></a>size |  a file with archive size data    |


