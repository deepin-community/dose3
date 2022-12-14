
##########
smallworld
##########


****
NAME
****


smallworld - compute detailed statistic about the dependency graph


********
SYNOPSIS
********


\ **smallworld**\  [option] ... \ *file*\  ...


***********
DESCRIPTION
***********


\ **smallworld**\  computes detailed statistic about the dependency graph. It
accepts


*******************
Input Specification
*******************


Currently supported input types are cudf, debian, rpm, opencsw and eclipse. The
\ **distcheck**\  tool expects its input specifiations in the form
\ *type://pathname*\  where \ *type*\  is one of \ **cudf**\ , \ **deb**\ , \ **synthesis**\ ,
\ **hdlist**\ , \ **csw**\  or \ **eclipse**\ , and \ *pathname*\  is the pathname of a file
containing the input. The package metadata found in that file must
correspond to the \ *type*\  given in the URI.


********************
Output Specification
********************


The output of smallworld is in YAML formar and it is structured as follows :

Generic Characteristics : Number of vertex and edges of the graph

Connectivity Properties : 
The degree of a vertex is the total number of vertices adjacent to the vertex.

Average Degree :
The average degree of a graph G is another measure of how many edges are in 
set E compared to number of vertices in set V.

Zero Degree Vertex:
The number of vertex that have zero degree.

Density : 
The density of a graph G = (V,E) measures how many edges are in set E compared 
to the maximum possible number of edges between vertices in set V.

Weakly Connected Components :
The weakly connected components are computed by considering the undirected
graph of dependencies. This is a useful measure of the number of isolated
components in the graph.

Strongly Connected Components :
A a strongly connected component of a directed graph is a subgraph where all
nodes in the subgraph are reachable by all other nodes in the subgraph.

SmallWorld Properties

Small world graphs are hightly clustered like regular graphs are lacttices, 
yet they have typically short distances between pair of vertices like in 
random graphs. The structural properties are quantified by two metrics: the 
average path length and the clustering coefficient.

Average Shortest Path Length :
The average shortest path is defined as the average number of steps along 
the shortest paths for all possible pairs of network nodes. The average path
length gives the expected distance between two connected nodes.

Average two step reach :
The average two step reach report the likewood of two vertex be be reachable in
two steps.

The network diameter is the largest distance between two nodes.
The diameter can also be described as the maximum node eccentricity.
The network radius is the minimum among the non-zero eccentricites of the nodes in the network.

Centrality Properties

Generic : 
Vertex : 22311
Edges : 107796
Connectivity : 
Average Out-Degree : 4.83
Average In-Degree : 4.83
Weakly Connected Components : 
Number of Components WC : 1425
Average Components WC : 15.66
Larges Component WC : 20831
Strongly Connected Components : 
Number of Components SC : 22010
Average Components SC : 1.01
Larges Component SC : 77
Small World : 
Clustering Coefficient : 0.41
Average Shortest Path Length : 3.18
Density : 0.00022
Average two step reach : 14.97
Centrality : 
Centrality Out Degree : 0.00471
Centrality In Degree : 0.46787


*******
OPTIONS
*******



- \ **-g --generic**\  =item \ **-p --scatterplots**\ 
=item \ **--combine-scatter**\ 
=item \ **-c --connectivity**\ 
=item \ **-m --components**\ 
=item \ **-s --smallworld**\ 
=item \ **-e --centrality**\ 
=item \ **--strong-deps**\ 
=item \ **--detrans**\ 
=item \ **--transitive-closure**\ 



- \ **-v**\ 
 
 Enable info / warnings / debug messages. This option may be repeated up to
 three times in order to increase verbosity.
 


- \ **-h**\ , \ **--help**\ 
 
 Display this list of options.
 



*******
EXAMPLE
*******



.. code-block:: perl

  smallworld deb:///var/lib/apt/lists/ftp.fr.debian.org_debian_dists_sid_main_binary-amd64_Packages



*******
AUTHORS
*******


Pietro Abate and Jaap Boender


********
SEE ALSO
********


<http://www.mancoosi.org> is the home page of the Mancoosi project.

