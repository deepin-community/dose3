
#############
dose-outdated
#############


****
NAME
****


outdated - detect uninstallable packages due to obsolete dependencies


********
SYNOPSIS
********


\ **outdated**\  [option] ... \ *file*\  ...


***********
DESCRIPTION
***********


\ **outdated**\  identifies in a debian package repository those packages that
are not installable with respect to that repository by the their inter-package
relationships (dependencies, conflicts, ...), and that furthermore cannot
become installable (in the current version) how matter how the rest of the
repository evolves. This means that this package has to be updated in the
repository to ever become installable again.


*******************
Input Specification
*******************


Input files have to contain stanzas in the format of
deb-control(5), separated by one blank line. For instance, the
Packages files as found on a Debian mirror server, or in the directory
\ */var/lib/apt/lists/*\  of a Debian system, are suitable as input. The
repository used in the analysis consists of the union of all packages 
from the input files.


********************
Output Specification
********************


The output of outdated is in the YAML format.


*******
OPTIONS
*******



- \ **-f --failure**\ 
 
 Print the list of broken packages
 


- \ **-e --explain**\ 
 
 Explain the results in more detail.
 


- \ **-s**\ 
 
 Print a summary of broken packages.
 


- \ **--dump**\ 
 
 Dump to standard output in CUDF format the packages that are internally  
 generated and exit (mostly useful for debugging purposes).
 


- \ **--checkonly**\  \ *package*\ [,\ *package*\ ] ...
 
 Specifies a list of packages to check. By default all packages are checked.
 Takes a comma-separated list of package names, each of them possibly with a
 version constraint, as argument.
 
 Example: --checkonly "libc6 , 2ping (>= 1.2.3-1)"
 


- \ **-v**\ 
 
 Enable info / warnings / debug messages. This option may be repeated up to
 three times in order to increase verbosity.
 


- \ **--progress**\ 
 
 Display progress bars.
 


- \ **-h**\ , \ **--help**\ 
 
 Display this list of options.
 



**********
EXIT CODES
**********


Exit codes 0-63 indicate a normal termination of the program, codes 64-127
indicate abnormal termination of the program (such as parse errors, I/O
errors).


*******
EXAMPLE
*******



.. code-block:: perl

  dose3-outdated -f -v /var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages



*******
AUTHORS
*******


Pietro Abate and Ralf Treinen


********
SEE ALSO
********


\ **distcheck**\ (5)
\ **challenged**\ (5)

<http://www.mancoosi.org> is the home page of the Mancoosi project.

