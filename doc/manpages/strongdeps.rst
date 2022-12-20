
##########
strongdeps
##########


****
NAME
****


strongdeps - indentify the strong dependency of a set of packages


********
SYNOPSIS
********


\ **strongdeps**\  [option] ... \ *file*\  ...


***********
DESCRIPTION
***********


\ **strongdeps**\  computes the strong dependencies and the impact set of a
set of packages. We say that p strongly depends on q if whenever p
is installed then q must also be installed. The impact set of a
package q is the set of all packages p that strongly depend on q.


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


The output of strongdeps is a CSV table containing strong dependencies, impact
set and direct dependencies. If the option \ **--checkonly**\  is spefified,
\ **strongdeps**\  prints on standard output the list of the packages that strong
depends on each of the given packages. If \ **--checkonly**\  if paired with
\ **--dot**\  then \ **strongdeps**\  prints on standard output the detransitivitazed
graph of the strong dependencies of each package in dot format.

N.B. Since \ **--checkonly**\  computes only the strong dependencies of a set of
packages, the impact set is not computed.


*******
OPTIONS
*******



- \ **--checkonly**\  \ *package*\ [,\ *package*\ ] ...
 
 Specifies a list of packages to check. By default all packages are
 checked. \ **--checkonly**\  and \ **--table**\  are mutually exclusive.
 


- \ **--dot**\ 
 
 Print the strong dependency graph in dot format
 


- \ **--table**\ 
 
 Print the table (package,strong,direct,difference) in the file data.csv
 


- \ **--detrans**\ 
 
 Perform the transitive reduction of the strong dependency graph. This 
 option is implied by \ **--checkonly**\ 
 


- \ **--transitive-closure**\ 
 
 Perform the transitive closure of the direct dependency graph
 


- \ **--conj-only**\ 
 
 Use the conjunctive graph only
 


- \ **-v**\ 
 
 Enable info / warnings / debug messages. This option may be repeated up to
 three times in order to increase verbosity.
 


- \ **--progress**\ 
 
 Display progress bars.
 


- \ **-h**\ , \ **--help**\ 
 
 Display this list of options.
 



*******
EXAMPLE
*******



.. code-block:: perl

  strongdeps --dot --checkonly "2ping,libc6" \
  deb:///var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages
 
  strongdeps --table \
  deb:///var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages



*******
AUTHORS
*******


Pietro Abate, Jaap Boender, Roberto Di Cosmo


********
SEE ALSO
********


<http://www.mancoosi.org> is the home page of the Mancoosi project.

For a comprehensive explanation of the notion of strong dependency
and impact set see

Strong Dependencies between Software Components, 
by Pietro Abate, Jaap Boender, Roberto Di Cosmo, and Stefano Zacchiroli.
<http://mancoosi.org/reports/>

