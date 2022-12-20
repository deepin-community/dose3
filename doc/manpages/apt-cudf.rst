
########
apt-cudf
########


****
NAME
****


apt-cudf - CUDF solver integration for APT


********
SYNOPSIS
********



- \ **solvername**\ 




***********
DESCRIPTION
***********


apt-cudf translates back and forth among a CUDF-based dependency solver and the
protocol used by APT to talk with external dependency solvers. apt-cudf
therefore allows one to use any CUDF solver as an external solver for APT.

apt-cudf relies on its \ ``argv[0]``\  name to find the CUDF solver to invoke.  In
common setups, you should have a CUDF solver specification file under
\ */usr/share/cudf/solvers/*\  for each installed CUDF solver. To use one such
solver with APT, you should create a symbolic link pointing to
\ */usr/bin/apt-cudf*\  under \ */usr/lib/apt/solvers/*\  and call it with the name
of the CUDF solver you want to use.


*******
OPTIONS
*******



- -v



- --verbose
 
 Print debugging information during operation. Can be repeated.
 


- -h



- --help
 
 Show usage information and exit.
 


- --version
 
 Show program's version and exit.
 


- --dump
 
 Dump the cudf universe and solution
 


- --noop
 
 Dump the cudf universe and solution and exit. This is useful to generate a cudf universe from a edsp file
 


- --conf
 
 Use a configuration file. Default in /etc/apt-cudf.conf
 


- -s <solver>



- --solver <solver>
 
 Specify the external solver to use.
 


- -c <criteria>



- --criteria <criteria>
 
 Specify the optimization criteria in extended MISC 2012 syntax. This value will
 be converted into the optimization criteria language understood by the
 respective solver.
 
 As an extension to the MISC 2012 syntax, a variation of the count() measurement
 is supported by apt-cudf. The extension allows one to minimize or maximize the
 number of packages in a set that have an EDSP field matching a regular
 expression. Two formats exist. The first searches for a plain string within the
 EDSP field value:
 
 
 .. code-block:: perl
 
  	count(selector,field:=/plain/)
 
 
 While the second one understands the regular expression syntax of the OCaml
 Re_pcre module:
 
 
 .. code-block:: perl
 
  	count(selector,field:~/regex/)
 
 
 The regex or plain string are delimitered by any character (the slash was
 chosen in both above examples) but that character must not be part of the
 regex or plain string itself (there is no escaping mechanism).
 
 This option cannot be used together with the \ **--criteria-plain**\  option.
 


- --criteria-plain <criteria>
 
 This optimization criteria is passed directly to the solver without any prior
 parsing.
 
 This option cannot be used together with the \ **--criteria**\  option.
 


- -e



- --explain
 
 Print a human-readable summary of the solution.
 


- --native-arch
 
 Speficy the native architecture to be used in the edsp -> cudf translation. By default apt-cudf
 uses apt-config to deduce the native architecture. This option is useful if the edsp was generated
 on a machine with a different architecture.
 


- --foreign-archs
 
 A comma-separated list of foreign architectures to be used in the edsp -> cudf translation
 



********
EXAMPLES
********


Find a solution for installing the package ghc which minimizes the packages
from experimental:


.. code-block:: perl

 	APT_EDSP_DUMP_FILENAME=/tmp/dump.edsp apt-get --simulate install --solver dump -o APT::Solver::Strict-Pinning=false ghc
 	apt-cudf -v --solver=aspcud -c "-count(solution,APT-Release:=/a=experimental/),-removed,-changed,-new" /tmp/dump.edsp


Usually apt-cudf is not called directly by the user but indirectly by apt-get.
So the above would become:


.. code-block:: perl

 	apt-get --simulate install --solver aspcud -o APT::Solver::Strict-Pinning=false -o APT::Solver::aspcud::Preferences="-count(solution,APT-Release:=/a=experimental/),-removed,-changed,-new" ghc/experimental



********
SEE ALSO
********


apt-get(8), update-cudf-solvers(8),
README.cudf-solvers|file:///usr/share/doc/apt-cudf/README.cudf-solvers,
README.Debian|file:///usr/share/doc/apt-cudf/README.Debian


******
AUTHOR
******


Copyright: (C) 2011 Pietro Abate <pietro.abate@pps.jussieu.fr>
Copyright: (C) 2011 Stefano Zacchiroli <zack@debian.org>

License: GNU Lesser General Public License (GPL), version 3 or above

