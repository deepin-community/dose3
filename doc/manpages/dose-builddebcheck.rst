
##################
dose-builddebcheck
##################


****
NAME
****


dose-builddebcheck - Check if a package can be built on a Debian system


********
SYNOPSIS
********



- \ **dose-builddebcheck**\   \ **--deb-native-arch=**\ \ *name*\  [options] \ *binary-repositories*\  \ *source-repository*\ 




***********
DESCRIPTION
***********


dose-builddebcheck determines, for a set of debian source package
control stanzas, called the source repository, whether a build
environment for the packages of the source repository can be installed
on the specified native architecture by using packages from the binary
repository. For this, only package meta-information is taken into
account: build-dependencies and build-conflicts in the source package,
and inter-package relationsships expressed in the binary
repository. The constraint solving algorithm is complete, that is it
finds a solution whenever there exists one, even for multiple
disjunctive dependencies and deep package conflicts.  This problem is
computationally infeasible in theory (that is, NP-complete), but can
be solved very efficiently for package repositories that actually
occur in practice. Installability of binary packages is analyzed
according to their \ **Depends**\ , \ **Conflicts**\ , and \ **Provides**\  fields
with their meaning as of Debian policy version 3.9.0. \ **Pre-depends**\ 
are treated like \ **Depends**\ , and \ **Breaks**\  are treated like
\ **Conflicts**\ .


************
INPUT FORMAT
************


The \ **binary-repositories**\  argument is a list of filenames containing stanzas
in the format of deb-control(5), separated by one blank line. For instance,
the Packages files as found on a Debian mirror server, or in the directory
\ */var/lib/apt/lists/*\  of a Debian system, are suitable. The
\ **source-repository**\  argument is the name of a file containing debian source
control stanzas, separated by one blank line. For instance, the Sources files
as found on a Debian mirror server, or in the directory \ */var/lib/apt/lists/*\ 
of a Debian system, are suitable. \ **binary-repositories**\  and
\ **source-repository**\  can be passed in compresssed format (.gz , .bz2).

Multi-arch annotations are correctly considered by dose-builddebcheck. Packages
whose's architecture is neither the native architecture nor in the list of
foreign architectures (see below) are ignored. Here, native and foreign refers
at the same time to the architecture on which the compilation will be run, and
to the host architecture of the compilation. Cross-compilation is supported
by specifying the \ *host*\  architecture.


*******
OPTIONS
*******


MISC OPTIONS
============



- \ **--version**\ 
 
 Show program's version and exit.
 


- \ **-h, --help**\ 
 
 This option displays the help message.
 


- \ **-v, --verbose**\ 
 
 Enable info / warnings / debug messages. This option may be repeated up
 to three times in order to increase verbosity.
 


- \ **--progress**\ 
 
 Print progress bars.
 


- \ **--timers**\ 
 
 Print timing information.
 


- \ **--quiet**\ 
 
 Do no print any messages.
 



DISTCHECK OPTIONS
=================



- \ **-e, --explain**\ 
 
 Give explanations. If used together with --failures then the explanation
 consists of dependency chains leading to a conflict or a dependency on a
 missing package. If used together with --successes then the explanation
 consists of an installation set.
 


- \ **-m**\ , \ **--explain-minimal**\ 
 
 For all packages \ **P**\  that are found installable, and when used in conjunction
 with \ **--successes**\ , prints a reduced installation set containing only those
 packages in the dependency cone of \ **P**\ . When used with Debian repositories,
 all essential packages and their dependencies that are not in the cone of \ **P**\ 
 are omitted.  When used in conjunction with \ **--failures**\ , and \ **--explain**\ ,
 all dependencies chains are not printed.
 


- \ **-c**\ , \ **--explain-condense**\ 
 
 Compress explanation graph
 


- \ **-f --failures**\ 
 
 Only show broken packages that fail the installability check.
 


- \ **-s --successes**\ 
 
 Only show packages that do not fail the installability check.
 


- \ **--summary**\ 
 
 Gives a more detailed summary of the findings.
 



INPUT OPTIONS
=============



- \ **--checkonly**\  \ *package*\  [,\ *package*\ ] ...
 
 Takes a comma-separated list of package names, each of them possibly with a version
 constraint, as argument. The foreground is constituted of all packages
 that match any of the expressions, all other packages are pushed into
 the background. The initial distinction between foreground and background is
 ignored. This option must not be combined with \ **--coinst**\ .
 
 Example: --checkonly "libc6 , 2ping (= 1.2.3-1)"
 


- \ **--latest**\  \ *n*\ 
 
 Consider only the latest -\ *n*\  most recent versions of each package,
 older versions of packages are ignored.
 



OUTPUT OPTIONS
==============



- \ **-o, --outfile=**\  \ *file*\ 
 
 Send output to \ *file*\ .
 


- \ **-d, --outdir=**\  \ *directory*\ 
 
 Set the output directory (default current directory).
 


- \ **--dot**\ 
 
 Save the explanation graph (one for each package) in dot format.
 


- \ **--dump=**\ \ *file*\ 
 
 Dump the cudf file.
 



DEBIAN OPTIONS
==============



- \ **--deb-native-arch=**\ \ *name*\ 
 
 Specify the native architecture. This argument is mandatory.
 


- \ **--deb-host-arch=**\ \ *name*\ ...
 
 Specify the host architecture.
 


- \ **--deb-foreign-archs=**\ \ *name*\  [,\ *name*\ ] ...
 
 Specify a comma-separated list of foreign architectures. The default
 is an empty list of foreign architectures. If \ **--deb-host-arch**\  is set, it
 is used as an implicit foreign architecture.
 


- \ **--deb-ignore-essential**\ 
 
 Do not consider essential packages as part of the installation problem.
 By default all essential package are considered as part of the
 installation problem for all packages, that is a package is installable
 if and only if it is co-installable with all essential packages. This
 option allows the user to test the installability with no essential
 packages installed.
 


- \ **--deb-builds-from**\ 
 
 Add builds-from relationship of binary packages on source packages as
 dependency. This allows one to create graphs for bootstrapping purposes.
 


- \ **--deb-tupletable=**\ \ *file*\ 
 
 Path to an architecture tuple table like /usr/share/dpkg/tupletable
 


- \ **--deb-cputable=**\ \ *file*\ 
 
 Path to a cpu table like /usr/share/dpkg/cputable
 


- \ **--deb-defaulted-m-a-foreign**\ 
 
 Convert Arch:all packages to Multi-Arch: foreign
 


- \ **--deb-drop-b-d-indep**\ 
 
 Drop Build-Indep dependencies
 


- \ **--deb-drop-b-d-arch**\ 
 
 Drop Build-Arch dependencies
 


- \ **--deb-include-extra-source**\ 
 
 Include packages with Extra-Source-Only:yes (dropped by default)
 


- \ **-P, --deb-profiles=**\ \ *name*\ [,\ *name*\ ...]
 
 Comma separated list of activated build profiles.
 


- \ **--deb-emulate-sbuild**\ 
 
 Replicate sbuild behaviour to only keep the first alternative of build
 dependencies.
 




**********
EXIT CODES
**********


Exit codes 0-63 indicate a normal termination of the program, codes 64-127
indicate abnormal termination of the program (such as parse errors, I/O
errors).

In case of normal program termination:

- exit code 0 indicates that all foreground packages are found installable;

- exit code 1 indicates that at least one foreground package is found uninstallable.


*******
EXAMPLE
*******


Compute the list of source packages in Sources for which
it is not possible to install a build environment on i386, assuming that
the binary packages described in file Packages are available:


.. code-block:: perl

  dose-builddebcheck -v -f -e --deb-native-arch=amd64 \
  /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages\
  /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_source_Sources


Compute the list of source packages for armel in Sources for which it is not
possible to install a mix build environment on amd64 plus armel, assuming that
the binary packages described in file Packages are available:


.. code-block:: perl

  deb-builddebcheck --failures --successes --deb-native-arch=amd64 \
  --deb-foreign-archs=armel,linux-any --deb-host-arch=armel \
  DebianPackages/Sid-amd64-armel-Packages-050812.bz2 
  DebianPackages/Sid-Sources-single-version-050812.bz2



******
AUTHOR
******


The current version has been rewritten on the basis of the dose3 library by
Pietro Abate; it replaces an earlier version that was  simply a wrapper for
edos-distcheck.


********
SEE ALSO
********


\ **deb-control**\ (5), 
\ **dose3-distcheck**\ (1)

<http://www.edos-project.org> is the home page of the EDOS project. 
<http://www.mancoosi.org> is the home page of the Mancoosi project.

