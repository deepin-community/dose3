[[!meta title=""]]

Using Dose3 from the OCaml interpreter
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To experiment with dose from the ocaml interpreter, you can use findlib
to load specific components.

::

   $ocaml
           Objective Caml version 3.12.1

   Findlib has been successfully loaded. Additional directives:
     #require "package";;      to load a package
     #list;;                   to list the available packages
     #camlp4o;;                to load camlp4 (standard syntax)
     #camlp4r;;                to load camlp4 (revised syntax)
     #predicates "p,q,...";;   to set these predicates
     Topfind.reset();;         to force that packages will be reloaded
     #thread;;                 to enable threads

   /usr/lib/ocaml/extlib: added to search path
   /usr/lib/ocaml/extlib/extLib.cma: loaded
   # #require "dose3";;
   /usr/lib/ocaml/str.cma: loaded
   /usr/lib/ocaml/pcre: added to search path
   /usr/lib/ocaml/pcre/pcre.cma: loaded
   /usr/local/lib/ocaml/3.12.1/cudf: added to search path
   /usr/local/lib/ocaml/3.12.1/cudf/cudf.cma: loaded
   /usr/lib/ocaml/ocamlgraph: added to search path
   /usr/lib/ocaml/ocamlgraph/graph.cma: loaded
   /usr/lib/ocaml/unix.cma: loaded
   /usr/lib/ocaml/zip: added to search path
   /usr/lib/ocaml/zip/zip.cma: loaded
   /usr/lib/ocaml/bz2: added to search path
   /usr/lib/ocaml/bz2/bz2.cma: loaded
   /usr/local/lib/ocaml/3.12.1/dose3: added to search path
   /usr/local/lib/ocaml/3.12.1/dose3/common.cma: loaded
   /usr/local/lib/ocaml/3.12.1/dose3/algo.cma: loaded
   /usr/local/lib/ocaml/3.12.1/dose3/debian.cma: loaded
   /usr/local/lib/ocaml/3.12.1/dose3/eclipse.cma: loaded
   # #require "dose3.boilerplate";;
   /usr/local/lib/ocaml/3.12.1/dose3/rpm.cma: loaded
   /usr/local/lib/ocaml/3.12.1/dose3/boilerplate.cma: loaded
   #
