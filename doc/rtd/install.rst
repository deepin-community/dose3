[[!meta title=“Install”]]

Dependencies
~~~~~~~~~~~~

Dose3 needs ocaml >= 3.11.2 . On debian, dose3 **does not compile** on
debian lenny.

Required libraries ( DEBIAN / RPM ) :

-  libextlib-ocaml-dev / ocaml-extlib-devel
-  libre-ocaml-dev / ??
-  camlp4

Additional libraries (enable compilation with –with-) :

-  libpostgresql-ocaml-dev / ocaml-postgresql-devel
-  libsqlite3-ocaml-dev / ocaml-sqlite-devel
-  libzip-ocaml-dev / ?
-  libbz2-ocaml-dev and libbz2-dev / ?
-  libjson-static-camlp4-dev / ?
-  libocamlgraph-ocaml-dev / ?
-  libounit-ocaml-dev / ocaml-ounit-devel
-  librpm-dev / librpm-devel
-  libexpat-ocaml-dev (for –with-xml)
-  libbenchmark-ocaml-dev (for –with-benchmark)

To use rpm support, dose3 needs librpm > 4.6 To use ocamlgraph support,
dose3 needs libocamlgraph-ocaml-dev >= 1.8.4

Compile
~~~~~~~

To compile dose without any additional libraries :

::

   $aclocal -I m4
   $autoconf
   $./configure
   $make

the configure script accepts many optional arguments to enable different
features :

-  –with-rpm4
-  –with-rpm5
-  –with-xml
-  –with-ocamlgraph
-  –with-parmap
-  –with-zip
-  –with-bz2
-  –with-oUnit
-  –with-curl

[[libcudf|cudf]] is included in the source tree of dose3 available by
git but not in the dose3 release tarball. By default dose3 uses the
system wide version of libcudf. To use the version of libcudf in the
source tree you can specify –without-libcudf as configure option. If
using an independently installed version of libcudf you’ll need version
>= 0.6.2.

Example:
^^^^^^^^

::

   ./configure --with-ocamlgraph --with-zip --with-bz2

Building the documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~

“make doc” builds the documentation. For this it is necessary to have
configured with option –with-ocamlgraph. You also need to have installed
“graphviz”.

Install
~~~~~~~

::

   $./configure --prefix=/path/to/
   $make
   $make install

By default dose is installed in /usr/local/{lib,bin} . In this case root
privileges might be needed to install the library. Dose also ships a
META file compatible with ocamlfind.
