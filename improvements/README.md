## This file contains a version of CGA which deals with the permutation problem.
In this version I split the state into the term containing the path, which I call perm,  and the decision variables.
The difference of CGA for a permuation problem is in the way to perform crossover and mutation. In particular I want that  each person is represented only by one gene, in other words  I do not go twice to the same person in my path. This reduce consistently the size of the space, i.e. N! rather than N^N. I employ cyclic crossover and mutation by exchanging two genes.
Details can be obtained in the coursework located in
'../coursework2.pdf' 
or, in the overleaf:
[overleaf link](https://www.overleaf.com/read/wvdqhdxrfzfc)
The idea behind the permuation problem for CGA is in the course slides in this folder
