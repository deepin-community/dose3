
##################
dose-deb-coinstall
##################


****
NAME
****


dose-debcoinstall - calculate a coinstallation set of a given set of Debian binary packages


********
SYNOPSIS
********



- \ **dose-debcoinstall**\  [options] \ *binary-repositories*\ 




***********
DESCRIPTION
***********


dose-debcoinstall determines whether a set of foreground Debian binary packages
can be installed together given a set of background Debian binary packages. If
a valid coinstallation set exists, than it is printed on standard output; else
the application exists with exit code 1 and prints nothing.

If the \ **--src**\  option is given, then the associated source packages are
printed on standard output instead.

Packages are split into foreground and background: only packages in the
foreground are checked for coinstallability, but dependencies may be satisfied
by foreground packages and by background packages. By default, all packages are
in the foreground.


************
INPUT FORMAT
************


The \ **binary-repositories**\  argument is a list of filenames containing stanzas
in the format of deb-control(5), separated by one blank line. For instance,
the Packages files as found on a Debian mirror server, or in the directory
\ */var/lib/apt/lists/*\  of a Debian system, are suitable.

The \ **--src**\  option requires a file containing debian source control stanzas,
separated by one blank line. For instance, the Sources files as found on a
Debian mirror server, or in the directory \ */var/lib/apt/lists/*\  of a Debian
system, are suitable.


*******
OPTIONS
*******



- \ **--deb-native-arch=**\ \ *name*\ 
 
 Specify the native architecture. The default behavior is to deduce the native
 architecture from the first package stanza in the input that has an
 architecture different from all.
 


- \ **--deb-foreign-archs=**\ \ *name*\  [,\ *name*\ ] ...
 
 Specify a comma-separated list of foreign architectures. The default
 is an empty list of foreign architectures. If \ **--deb-host-arch**\  is set, it
 is used as an implicit foreign architecture.
 


- \ **--deb-host-arch=**\ \ *name*\ ...
 
 Specify the host architecture. If this option is given, \ **--deb-native-arch**\ 
 must also be set.
 


- \ **-f --failures**\ 
 
 Print a diagnostic in YAML format containing the list of packages that were
 attempted to install together and the result of the operation.
 


- \ **-v --successes**\ 
 
 Only show packages that do not fail the installability check.
 


- \ **-e --explain**\ 
 
 Explain the results in more detail providing the reason why some packages cannot
 be installed together.
 


- \ **--src=**\ \ *source-repository*\ 
 
 Instead of printing binary packages, print the associated source packages as
 given in the debian Sources file \ **source-repository**\ .
 


- \ **--dump=**\ \ *cudf-file*\ 
 
 Dump the CUDF universe to \ **cudf-file**\  representing the encoding of binary
 and source packages, plus the coinstallability request.
 


- \ **--fg=**\ \ *binary-repository*\ 
 
 Specify a foreground binary repository.
 


- \ **--bg=**\ \ *binary-repository*\ 
 
 Specify a background binary repository.
 


- \ **--latest**\  \ *n*\ 
 
 Consider only the latest -\ *n*\  most recent versions of each package,
 older versions of packages are ignored.
 


- \ **-v**\ 
 
 Enable info / warnings / debug messages. This option may be repeated up
 to three times in order to increase verbosity.
 


- \ **-h, --help**\ 
 
 Display this list of options.
 



**********
EXIT CODES
**********


Exit codes 0-63 indicate a normal termination of the program, codes 64-127
indicate abnormal termination of the program (such as parse errors, I/O
errors).

In case of normal program termination:

- exit code 0 indicates that a valid coinstallation set exists

- exit code 1 indicates that at no coinstallation set exists


*******
EXAMPLE
*******


Compute the list of binary packages needed to install all packages marked as
essential:


.. code-block:: perl

  grep-dctrl -X -FEssential yes \
  /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages \
  > essential
 
  dose-debcoinstall --deb-native-arch=amd64 \
  --bg /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages \
  --fg essential > essential_coinstall


Compute the list of source packages needed to build these packages:


.. code-block:: perl

  dose-debcoinstall --deb-native-arch=amd64 \
  --src /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_source_Sources \
  --bg /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages \
  --fg essential > essential_coinstall_src



******
AUTHOR
******


The current version has been rewritten on the basis of the dose3 library by
Pietro Abate.


********
SEE ALSO
********


\ **deb-control**\ (5),
\ **dose3-distcheck**\ (1)

<http://www.edos-project.org> is the home page of the EDOS project.
<http://www.mancoosi.org> is the home page of the Mancoosi project.

