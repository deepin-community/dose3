
Shell tutorial
~~~~~~~~~~~~~~

Exit codes allow for a convenient integration of installation checks as
tests in shell scripts.

Example: Suppose that you want to check installability of all .deb files
in the current directory with respect to the repository
unstable.packages before uploading your package described in
mypackage.changes:

::

   find . -name "*.deb" -exec dpkg-deb --info ’{}’ control \; -exec echo ""\; | \
   dose-debcheck --bg unstable.packages && dput mypackage.changes
