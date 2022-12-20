
############
apt-cudf-get
############


****
NAME
****


apt-cudf-get - wrapper for calling apt-get with external solvers


********
SYNOPSIS
********



- \ **apt-cudf-get**\  [arguments]




***********
DESCRIPTION
***********


\ **apt-cudf-get**\  is a wrapper that allows one to invoke \ **apt-get**\  with
external solvers while ignoring apt's pinning.

All options are passed on to apt-get.

Normally, apt uses so-called pinning to select a candidate version of
a package in case there are several versions available. This also
holds when calling apt-get with external solvers. However, when it is
not possible to find a solution under this constraint, it may be
useful to relax pinning and to allow the external solver to choose
among all available versions of packages in order to satisfy
dependencies, not only those that are selected by the pinning.  This
is precisely what apt-cudf-get does.

Note that, when using an external solver, the proposed solution may
contain any available version of the packages that are given as
arguments to install on the command line without specifying a version
qualifier.

For example


.. code-block:: perl

     apt-cudf-get --solver aspcud install ocaml


may propose to install any available version of ocaml, while


.. code-block:: perl

     apt-cudf-get --solver aspcud install ocaml=4.01.0


will only propose to install ocaml in version 4.01.0


******
AUTHOR
******


Pietro Abate and Roberto Di Cosmo


****
BUGS
****


Not all types of arguments to apt are correctly treated by this wrapper,
in particular not the +\ *pkg*\  and -\ *pkg*\  shorthands for installation and removal requests.


********
SEE ALSO
********


\ **apt-get**\ (8),
\ **apt-cudf**\ (1),
\ **apt-cudf.conf**\ (5),
\ **update-cudf-solvers**\ (8),
README.cudf-solvers <file:///usr/share/doc/apt-cudf/README.cudf-solvers>,
README.Debian <file:///usr/share/doc/apt-cudf/README.Debian>

