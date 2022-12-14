
Python tutorial
~~~~~~~~~~~~~~~

Distcheck output can be easily parsed from a Python program by using the
YAML parser (needs the Debian package python-yaml).

Example: If you have run debcheck with the option -f (and possibly with
the -s option in addition) you may obtain a report containing one non-
installable package (name and version) per line like this:

::

   import yaml
   doc = yaml.load(file(’output-of-distcheck’, ’r’))
   if doc[’report’] is not None:
     for p in doc[’report’]:
       if p[’status’] == ’broken’:
         print ’%s %s is broken’ (p[’package’], p[’version’])

A complete example of a python script that constructs a set of pseudo-
packages, runs dose-debcheck on it, and then processes the output is
given in the directory doc/examples/potential-file-overwrites.
