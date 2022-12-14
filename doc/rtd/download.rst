[[!meta title=“Get It”]]

###Git repository

This project’s Git repository can be checked out through anonymous
access with the following command.

::

   git clone https://gforge.inria.fr/git/dose/dose.git

Developer Access to the Git repository via SSH

Only project developers can access the Git repository via this method.
SSH must be installed on your client machine. Substitute developername
with the proper value. Enter your site password when prompted.

::

   git clone git+ssh://developername@scm.gforge.inria.fr//gitroot/dose/dose.git

Debian packages
~~~~~~~~~~~~~~~

Dose is part of debian wheezy, jessie and debian
[[unstable|https://packages.debian.org/source/sid/dose3]]

::

   apt-get install libdose3-ocaml-dev

Opam packages
~~~~~~~~~~~~~

The latest Dose release is available as opam
[[package|https://opam.ocaml.org/packages/dose/dose.3.3/]]

::

   opam init -y
   eval `opam config env`
   opam switch -y 4.02.0
   eval `opam config env`
   opam install -y extlib camlbz2 camlzip ocamlgraph extlib ounit re cudf
