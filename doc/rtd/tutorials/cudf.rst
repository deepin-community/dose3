Create a simple package repository
----------------------------------

First we instantiate three cudf packages (p1,p2,p3) and the create a
cudf universe containing these three packages.

::

   #let p1 = { Cudf.default_package with Cudf.package = "p1" ; version = 1 } 
    and p2 = { Cudf.default_package with Cudf.package = "p2" ; version = 1 }
    and p3 = { Cudf.default_package with Cudf.package = "p3" ; version = 1 }
    ;;
   val p1 : Cudf.package =
     {Cudf.package = "p1"; Cudf.version = 1; Cudf.depends = [];
      Cudf.conflicts = []; Cudf.provides = []; Cudf.installed = false;
      Cudf.was_installed = false; Cudf.keep = `Keep_none; Cudf.pkg_extra = []}
   val p2 : Cudf.package = [...]
   val p3 : Cudf.package = [...]

let’s now add a dependency from p1 to p2 OR p3

::

   # let p1 = { p1 with Cudf.depends = [[(p2.Cudf.package,None);(p3.Cudf.package,None)]] } ;;
   val p1 : Cudf.package =
     {Cudf.package = "p1"; Cudf.version = 1;
      Cudf.depends = [[("p2", None); ("p3", None)]]; Cudf.conflicts = [];
      Cudf.provides = []; Cudf.installed = false; Cudf.was_installed = false;
      Cudf.keep = `Keep_none; Cudf.pkg_extra = []}

and a conflict between p2 and p3. Notice that since conflicts are
symmetric, adding a conflict to the package p2 also adds and “implicit”
conflict on the package p3.

::

   # let p2 = { p2 with Cudf.conflicts = [(p3.Cudf.package,None)] } ;;
   val p2 : Cudf.package =
     {Cudf.package = "p2"; Cudf.version = 1; Cudf.depends = [];
      Cudf.conflicts = [("p3", None)]; Cudf.provides = [];
      Cudf.installed = false; Cudf.was_installed = false;
      Cudf.keep = `Keep_none; Cudf.pkg_extra = []}

we can now create a universe containing these three packages

::

   # let pkglist = [p1;p2;p3];;
   val pkglist : Cudf.package list =
   [...]

   #
   #let universe = Cudf.load_universe pkglist ;;
   val universe : Cudf.universe = <abstr>

The cudf document corresponding to this universe

::

   package: p1
   version: 1
   depends: p2 | p3

   package: p2
   version: 1
   conflicts: p3

   package: p3
   version: 1

Now that we have a cudf universe we want to check, for example, if a
package in this universe is installable, that is all its dependencies
can be satisfied in the given universe and the solution does not contain
any conflict.

Read/Write Cudf repositories
----------------------------

Suppose now we want to write to disk the cudf universe that we just
created. The module Cudf_printer contains all the i/o primitives to
manipulate cudf types.

::

   #let oc = open_out "universe.cudf" in
   Cudf_printer oc universe;
   close_out oc

To load a cudf universe from a file, we have two options, depending on
the situation. These functions are contained in the module Cudf_parser

Cudf_parser.parse_from_file “universe.cudf” will return a tuple
(preamble, package list, request) . Both the preamble and package list
are optional values.

Otherwise we can use the function Cudf_parser.load_from_file
“universe.cudf” that will return (preamble, universe, request) with, as
before , preamble and request optional values.

::

   #let (_,universe,_) = Cudf_parser.load_from_file "universe.cudf" ;;
