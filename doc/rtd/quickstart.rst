[[!meta title=“QuickStart”]]

Quick start
~~~~~~~~~~~

Dose is an ocaml library designed to analyse large software
repositories. The library core does not make any assumption of the
semantic and syntax of any specific packages systems and it is based on
the [[Cudf|cudf]] format.

In this tutorial we will work from the ocaml command line.

Create a simple package repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First we instantiate three cudf packages (p1,p2,p3) and the create a
cudf universe containing these three packages.

[[!format ocaml """ #let p1 = { Cudf.default_package with Cudf.package =
“p1” ; version = 1 } and p2 = { Cudf.default_package with Cudf.package =
“p2” ; version = 1 } and p3 = { Cudf.default_package with Cudf.package =
“p3” ; version = 1 } ;; val p1 : Cudf.package = {Cudf.package = “p1”;
Cudf.version = 1; Cudf.depends = []; Cudf.conflicts = []; Cudf.provides
= []; Cudf.installed = false; Cudf.was_installed = false; Cudf.keep =
\`Keep_none; Cudf.pkg_extra = []} val p2 : Cudf.package = […] val p3 :
Cudf.package = […] """ ]]

let’s now add a dependency from p1 to p2 OR p3

[[!format ocaml """ # let p1 = { p1 with Cudf.depends =
[[(p2.Cudf.package,None);(p3.Cudf.package,None)]] } ;; val p1 :
Cudf.package = {Cudf.package = “p1”; Cudf.version = 1; Cudf.depends =
[[(“p2”, None); (“p3”, None)]]; Cudf.conflicts = []; Cudf.provides = [];
Cudf.installed = false; Cudf.was_installed = false; Cudf.keep =
\`Keep_none; Cudf.pkg_extra = []} """ ]]

and a conflict between p2 and p3. Notice that since conflicts are
symmetric, adding a conflict to the package p2 also adds and “implicit”
conflict on the package p3.

[[!format ocaml """ # let p2 = { p2 with Cudf.conflicts =
[(p3.Cudf.package,None)] } ;; val p2 : Cudf.package = {Cudf.package =
“p2”; Cudf.version = 1; Cudf.depends = []; Cudf.conflicts = [(“p3”,
None)]; Cudf.provides = []; Cudf.installed = false; Cudf.was_installed =
false; Cudf.keep = \`Keep_none; Cudf.pkg_extra = []} """ ]]

we can now create a universe containing these three packages

[[!format ocaml """ # let pkglist = [p1;p2;p3];; val pkglist :
Cudf.package list = […]

#let universe = Cudf.load_universe pkglist ;; val universe :
Cudf.universe = """ ]]

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

The module Depsolver of dose expose hight level functions to check
installability in a given universe. For example :

[[!format ocaml """ # #require “dose3”;; […] # open Algo;; # let result
= Depsolver.edos_install universe p1;; val result :
Algo.Diagnostic.diagnosis = {Algo.Diagnostic.result =
Algo.Diagnostic.Success ; Algo.Diagnostic.request =
Algo.Diagnostic.Package {Cudf.package = “p1”; Cudf.version = 1;
Cudf.depends = []; Cudf.conflicts = []; Cudf.provides = [];
Cudf.installed = false; Cudf.was_installed = false; Cudf.keep =
\`Keep_none; Cudf.pkg_extra = []}} # """ ]]

The variable result if of type Algo.Diagnostic.diagnosis. Few help
functions exists in the Diagnostic module to analyse this result.

[[!format ocaml """ # Diagnostic.is_solution result;; - : bool = true #
Diagnostic.get_installationset result;; - : Cudf.package list =
[{Cudf.package = “p1”; Cudf.version = 1; Cudf.depends = [[(“p2”, None);
(“p3”, None)]]; Cudf.conflicts = []; Cudf.provides = []; Cudf.installed
= true; Cudf.was_installed = false; Cudf.keep =
``Keep_none; Cudf.pkg_extra = []};  {Cudf.package = "p3"; Cudf.version = 1; Cudf.depends = [];   Cudf.conflicts = []; Cudf.provides = []; Cudf.installed = true;   Cudf.was_installed = false; Cudf.keep =``\ Keep_none;
Cudf.pkg_extra = []}] """ ]]

We notice that the installation set of the package p1 is composed of
package p1 and package p3. Since p1 depends by either p2 or p3, in this
instance, the solver arbitrarily choose p3 over p2.

No suppose we want to check if we can install together p2 and p3. The
function Depsolver.edos_coinstall allows us to specify a list of
packages to be co-installed.

[[!format ocaml """ # let result = Depsolver.edos_coinstall universe
[p2;p3];; val result : Algo.Diagnostic.diagnosis =
{Algo.Diagnostic.result = Algo.Diagnostic.Failure ;
Algo.Diagnostic.request = Algo.Diagnostic.PackageList [{Cudf.package =
“p2”; Cudf.version = 1; Cudf.depends = []; Cudf.conflicts = [(“p3”,
None)]; Cudf.provides = []; Cudf.installed = false; Cudf.was_installed =
false; Cudf.keep =
``Keep_none; Cudf.pkg_extra = []};       {Cudf.package = "p3"; Cudf.version = 1; Cudf.depends = [];        Cudf.conflicts = []; Cudf.provides = []; Cudf.installed = false;        Cudf.was_installed = false; Cudf.keep =``\ Keep_none;
Cudf.pkg_extra = []}]} """ ]]

Since p2 and p3 are in conflict, this request cannot be satisfied.

[[!format ocaml """ # Diagnostic.is_solution result;; - : bool = false
""" ]]
