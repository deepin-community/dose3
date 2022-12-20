
###############
dose-challenged
###############


****
NAME
****


challenged - detect broken packages due to obsolete dependencies


********
SYNOPSIS
********



- \ **challenged**\  [options] \ *Packages file(s)*\ 




***********
DESCRIPTION
***********


challenged performs a speculative analysis of the repository to identify those
packages that, if upgraded to a specific version, would break a large number of
other packages in the repository. This tool would be particularly useful during
the upgrade of a specific component to evaluate its impact on the software
archive.


*******************
Input Specification
*******************


The input of challenged is a list of Debian Packages files


********************
Output Specification
********************


The output of challenged is in the yaml format.


*******
Options
*******



- \ **-b --broken**\ 
 
 Print the list of broken packages
 


- \ **-d --downgrade**\ 
 
 Check package downgrades
 


- \ **-c**\ 
 
 Print the list of packages in a cluster
 


- \ **--checkonly**\  \ *package*\ [,\ *package*\ ] ...
 
 Specifies a list of packages to check. By default all packages are checked.
 Takes a comma-separated list of package names and a version .
 
 Example: --checkonly "libc6 (=1.4), 2ping (= 1.2.3-1)"
 


- \ **-v**\ 
 
 Enable info / warnings / debug messages. This option may be repeated up to
 three times in order to increase verbosity.
 


- \ **--progress**\ 
 
 Enable progress bars.
 


- \ **-h, --help**\ 
 
 Display this list of options.
 



*******
EXAMPLE
*******



.. code-block:: perl

   challenged -v --progress Packages.bz2 > result.yaml



****
NOTE
****



******
AUTHOR
******


Pietro Abate and Roberto Di Cosmo


********
SEE ALSO
********


\ **distcheck**\ (1)\ ****\ 
\ **outdated**\ (1)\ ****\ 

<http://www.mancoosi.org> is the home page of the Mancoosi project.

