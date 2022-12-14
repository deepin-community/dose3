
#############
apt-cudf.conf
#############


****
NAME
****


apt-cudf.conf - Configuration file for apt-cudf


***********
DESCRIPTION
***********


The configuration file allows one to define default optimization criteria for
all solvers known by apt-cudf


******
SYNTAX
******



.. code-block:: perl

   solver: <solver list> | '*'


A comma-separated list of solvers. The character will make the optimization criteria
as default for all solvers without a more specific definition.


.. code-block:: perl

   upgrade: <optimization criteria>
   dist-upgrade: <optimization criteria>
   install: <optimization criteria>
   remove: <optimization criteria>


Default optimization criteria associated to apt-get actions. The optimization criteria
is solver specific. Specifying a incorrect criteria will result in an error from the 
underlying cudf solver. Please refere to the solver man page for the correct syntax


.. code-block:: perl

   trendy: <optimization criteria>
   paranoid: <optimization criteria>
   <keyword>: <optimization criteria>


Define a shortcut for an optimization criteria. The shortcut can then be used by apt-get
to pass a specific optimization criteria for a cudf solver


.. code-block:: perl

   apt-get install gnome --solver aspcud -o "APT::Solver::aspcud::Preferences=trendy"



*******
EXAMPLE
*******



.. code-block:: perl

   solver: mccs-cbc , mccs-lpsolve
   upgrade: -lex[-new,-removed,-notuptodate]
   dist-upgrade: -lex[-notuptodate,-new]
   install: -lex[-removed,-changed]
   remove: -lex[-removed,-changed]
   trendy: -lex[-removed,-notuptodate,-unsat_recommends,-new]
   paranoid: -lex[-removed,-changed]
 
   solver: *
   upgrade: -new,-removed,-notuptodate
   dist-upgrade: -notuptodate,-new
   install: -removed,-changed
   remove: -removed,-changed
   trendy: -removed,-notuptodate,-unsat_recommends,-new
   paranoid: -removed,-changed



********
SEE ALSO
********


apt-cudf(8), apt-get(8), update-cudf-solvers(8),
README.cudf-solvers|file:///usr/share/doc/apt-cudf/README.cudf-solvers,
README.Debian|file:///usr/share/doc/apt-cudf/README.Debian


******
AUTHOR
******


Copyright: (C) 2011 Pietro Abate <pietro.abate@pps.jussieu.fr>
Copyright: (C) 2011 Stefano Zacchiroli <zack@debian.org>

License: GNU Lesser General Public License (GPL), version 3 or above

