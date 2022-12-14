[[!meta title=“Dose FAQ”]]

Not all source packages are considered by dose-builddebcheck
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   % dose-builddebcheck --deb-native-arch=amd64 --dump=cudf Packages.bz2 Sources.bz2
   native-architecture: amd64
   background-packages: 55890
   foreground-packages: 18109
   broken-packages: 60

However, the file Source.bz2 contains more source packages than that:

% grep -c ^Package: Sources 18375

That means that 266 source stanzas have not been taken into account.

These packages were ignored because they have an architecture different
from amd64. In the invocation above the target distribution is amd64 and
therefore packages, for example, that should be compiled on armel only
are ignored. Adding -v -v will show you the list of packages that are
ignored.

Ask you question !
~~~~~~~~~~~~~~~~~~
