[[!meta title=“Where it is Used”]]

[[Botch|https://gitorious.org/debian-bootstrap/pages/Home]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Botch stands for Bootstrap/Build Order ToolCHain. It consists of a
number of tools that aid in breaking dependency cycles and generating a
build order so that Debian can be bootstrapped.

[[Opam|http://opam.ocamlpro.com/]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OPAM is an open-source package manager for the OCaml programming
language. It supports multiple simultaneous compiler installations,
flexible package constraints, and a Git-friendly development workflow.

Apt-Get (via [[man/apt-cudf]])
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apt-get is the standard package manager for debian. Using apt-cudf it
can use external dependency solvers using the ‘–solver’ command line
option.

[[Debian Weather Service|https://qa.debian.org/dose/]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dose/Ditscheck is used by the Debian QA team as an ongoing effort to
detect and fix installability related bugs.

[[Opam Weather Service|http://ows.irill.org/index.html]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OWS uses distcheck to check the health of the official OPAM
repository.

[[Equinox P2 Cudf Resolver|http://wiki.eclipse.org/Equinox/p2/CUDFResolver]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A frontend to p2 that allows p2 to resolve Linux dependencies. The input
and output format is CUDF. This format has been designed by the Mancoosi
European project to foster improvements in dependency resolution
solvers.

[[Mancoosi Project|http://mancoosi.org/]]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mancoosi was a European research project in the 7th Research Framework
Programme (FP7) of the European Commission. The project started February
1st, 2008, and closed in 2012. The Dose library was developed during
this time.
