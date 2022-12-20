
#########
dose-ceve
#########


****
NAME
****


ceve - parse package metadata


********
SYNOPSIS
********



- \ **ceve**\  [-h] [-v] [-c \ *pkgspec*\ ] [-r \ *pkgspec*\ ] [--depth=\ *n*\ ]\ **\  [-T \ *format*\ ] [-G \ *graph type*\ ] [-o \ *filename*\ ] \ *input-spec*\  [\ *input-spec*\ ...]




***********
DESCRIPTION
***********


Ceve is a generalized metadata parser. It reads package specifications,
extracts package metadata from them, performs some manipulations, and outputs
the package metadata in one of several formats.

\ *input-spec*\  is a url specifying the input format and the file to get the
input from. For a possible list of schemes, see the \ **-t**\  parameter.

Some examples of URLs:


- .
 
 deb://Packages.gz (the Debian file packages.gz in the current directory)
 


- .
 
 cudf:///home/examples/cudf/test.cudf (the CUDF file /home/examples/cudf/test.cudf)
 



*******
OPTIONS
*******


MISC OPTIONS
============



- \ **-h, --help**\ 
 
 This option displays the help message.
 


- \ **-v, --verbose**\ 
 
 Be verbose. This option can be repeated for more verbosity.
 


- \ **--version**\ 
 
 Show program's version and exit.
 


- \ **--progress**\ 
 
 Print progress bars.
 


- \ **--timers**\ 
 
 Print timing information.
 


- \ **--quiet**\ 
 
 Do no print any messages.
 



INPUT OPTIONS
=============


Dose3 accepts files compressed with gzip(1) or bzip2(1), depending on
compile-time options.


- \ **-t **\ \ *input-spec*\ 
 
 Select the input type. Possible values are:
 


- .
 
 \ **cudf**\  Cudf file format
 


- .
 
 \ **pef**\  PEF file format. The PEF format (Package Exchange Format) is a generic 822
 file format used to encode package dependencies. \ **deb**\ , \ **opam**\ , \ **debsrc**\  and 
 \ **edsp**\  are all based on the pef format
 


- .
 
 \ **csw**\  OpenCSW Solaris packages binary format
 


- .
 
 \ **opam**\  Opam Package universe in Opam/PEF format. This format is a 822 textual 
 format encoding the opam universe.
 


- .
 
 \ **deb**\  for Debian binary package files, also known as Packages files.
 


- .
 
 \ **debsrc**\  for Debian source package files, also knows as Sources files.
 


- .
 
 \ **edsp**\  apt-get External Dependency Solver Protocol
 


- .
 
 \ **hdlist**\  RPM hdlists. Binary file format.
 


- .
 
 \ **synthesis**\  urpmi synthesis hdlists. XML Based format
 


- \ **--trim**\ 
 
 Consider only installable packages.
 


- \ **--latest**\  \ *n*\ 
 
 Consider only the latest -\ *n*\  most recent versions of each package,
 older versions of packages are ignored.
 


- \ **-c, --cone=**\ \ *vpkglist*\ 
 
 The \ **match**\  of an atomic dependency (a package name p possibly together with a
 version constraint c) is the set of all packages in the repository with name p,
 and a version that satisfies the constraint c.  The dependency cone of a
 package p is the set of all matches of all atomic dependencies of p, together
 with their respective dependency cones. The package specification \ *pkgspec*\  is
 a list of packages (separated by a semicolon), where each package is specified
 as follows: (\ *name*\ ,\ *version*\ ).
 
 This option extracts the union of the dependency cones of all packages selected
 by \ *vpkglist*\ .
 
 Example:
 =over 12
 


- -c 'golang-golang-x-tools (= 1:0.0~git20150716.0.87156cb+dfsg1-4),golang-golang-x-tools-dev'



- \ **-r, --rcone=**\ \ *vpkglist*\ 
 
 Using the same syntax as in \ **-c**\ , this option use the reverse dependency
 relation to make the transitive closure.
 


- \ **--depth **\ \ *n*\ 
 
 In combination with the \ **-c**\  or \ **-r**\  options, this specifies the
 maximum depth for the transitive closure.
 


- \ **--request **\ \ *installation-request*\ 
 
 Specifies an installation request of the form "\ **install:**\  \ *vpkglist*\ " or
 "\ **remove:**\  \ *vpkglist*\ " or "\ **upgrade:**\  \ *vpkglist*\ " where \ *vpkglist*\  is a
 list of (real) packages possibly associated with a constraint. Ex.: bash (<
 2.0), exim (= 3.1-debian1). This option can be repeated to specify install,
 remove and upgrade actions.
 
 Examples:
 
 
 - --request "install: bash (< 2.0), exim (= 3.1-debian1)" --request "upgrade: apt-cudf"
 
 
 



OUTPUT OPTIONS
==============



- \ **-o, --outfile=**\ \ *filename*\ 
 
 Instead of stdout, send output to the file \ *filename*\ .
 


- \ **-d, --outdir=**\ \ *directory*\ 
 
 Set the output directory (default current directory)
 


- \ **--dot**\ 
 
 Save the explanation graph (one for each package) in dot format.
 


- \ **-G **\ \ *graph type*\ 
 
 Specifies the graph type format to compute. This option must be used together
 with the option \ **-T **\ \ *dot|gml|grml*\ . Default is \ **syn**\ . Possible values are:
 


- .
 
 \ **syn**\  for the syntactic graph where disjunctions nodes and conflicts are
 explicitly added to the graph.
 


- .
 
 \ **pkg**\  for the package graph where all dependencies are threated uniformely and
 conflicts are not added to the graph.
 


- .
 
 \ **strdeps**\  the strong dependency graph. A package p strong depends on q iff p
 cannot be installed if q is not installed.
 


- .
 
 \ **strcnf**\ 
 


- .
 
 \ **conj**\  the conjunctive graph where only conjunctive dependencies are
 considered.
 


- .
 
 \ **dom**\ 
 


- \ **-T **\ \ *format*\ 
 
 Specifies the output format to use. Default is \ **cnf**\ . Possible values are:
 


- .
 
 \ **cnf**\  output in CNF format.
 


- .
 
 \ **dimacs**\  output in DIMACS format for CNF formulae.
 


- .
 
 \ **cudf**\  pretty-printed output in an RFC 822-like format
 


- .
 
 \ **deb**\  binary packages in deb822 format.
 


- .
 
 \ **debsrc**\  source packages in deb822 format.
 


- .
 
 \ **dot**\  a graph in Dot/GraphViz format.
 


- .
 
 \ **gml**\  a graph in GML format.
 


- .
 
 \ **grml**\  a graph in GraphML format.
 


- .
 
 \ **table**\  plain text output of three integer values: the universe size, the
 number of edges in the dependency graph, the number of conflicts in the
 universe.
 



DEBIAN SPECIFIC OPTIONS
=======================


Multi-arch annotations are handled by ceve. Packages whose's architecture is
neither the native architecture nor in the list of foreign architectures (see
below) are ignored.


- \ **--deb-native-arch=**\ \ *name*\ 
 
 Specify the native architecture. The default behavior is to deduce
 the native architecture from the first package stanza in the input
 that has an architecture different from all.
 


- \ **--deb-foreign-archs=**\ \ *name*\  [,\ *name*\ ] ...
 
 Specify a comma-separated list of foreign architectures. The default
 is an empty list of foreign architectures.
 


- \ **--deb-ignore-essential**\ 
 
 By default all essential package are considered as a dependency of all packages
 in the universe. This option allows the user to ignore essential packages.
 


- \ **--deb-host-arch=**\ \ *name*\ 
 
 Native/cross compile host architecture, defaults to native architecture.
 


- \ **--deb-builds-from**\ 
 
 Add builds-from relationship of binary packages on source packages as
 dependency. This allows one to create graphs for bootstrapping purposes.
 


- \ **-P, --deb-profiles=**\ \ *name*\ [,\ *name*\ ...]
 
 Comma separated list of activated build profiles.
 


- \ **--deb-drop-b-d-indep**\ 
 
 Drop Build-Depends-Indep dependencies from Debian source packages.
 


- \ **--deb-drop-b-d-arch**\ 
 
 Drop Build-Depends-Arch dependencies from Debian source packages.
 




********
EXAMPLES
********


Find all the reverse binary dependencies of the package \ **patchutils**\ :


.. code-block:: perl

 	dose-ceve --deb-native-arch amd64 -r patchutils -T deb \
 		deb:///var/lib/apt/lists/*_dists_sid_main_binary-amd64_Packages \
 		| grep-dctrl -n -s Package '' | sort -u


Find all the source packages that (directly or indirectly) build depend on
\ **patchutils**\ :


.. code-block:: perl

 	dose-ceve -T debsrc --deb-native-arch=amd64 -r patchutils \
 		debsrc:///var/lib/apt/lists/*_dists_sid_main_source_Sources \
 		deb:///var/lib/apt/lists/*_dists_sid_main_binary-amd64_Packages \
 		| grep-dctrl -n -s Package '' | sort -u


Find the source packages (-T debsrc) that have in a relation builds-from with
all the binary package in the reverse dependency cone of \ **libssl-dev**\  (a
specific version constraint).


.. code-block:: perl

   dose-ceve --deb-builds-from --deb-native-arch=amd64 -T debsrc \
   -r 'libssl-dev (>= 0.9.8)' deb://Sid-amd64-Packages-050812.bz2 \
   debsrc://Sid-Sources-050812.bz2


