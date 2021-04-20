# recycle_gift
This project consider the problem of exchanging gifts in a social network during a major festivity,e.g Easter eggs. The aim of the user “A” is to make gifts to all of their friends by recycling as many gifts as possible. In other words, “A” wants to minimise the number of gifts to be bough.However, "A" does not want to recicle the gift to a friend if the original donor and the new receipient know each other. Therefore, this code try to find the optimal way to recycle gift to satisfy the constrains given by social interactions.
## HOW TO RUN
1. first run ' create_social_interactions.m' function which creates the network. This function depends on a parameter which is the number of nodes in the network. From each node start 0.8XN links (a bit less because self connection are eliminated).
2. If you like to print the graph run 'plot interactions'
3. Then, choose the algorithm for minimisation. The coursework asked to repeat the simulation 10 times, therefore: 'many_cga' 'bga' 'many_pso' and 'es1p1' contains 10 repetition of the same code to evaluate reliability. `cga' and `pso' do not repet the code. They are useful for testing.
### Improvements
Contains a version that effectivly deal with permutation problem. There is another Readme there.
### What the other files contains?
- 'make_presents.m' is the cost function
- 'neighbour.mat' contains the topology, it is produced in the step 1.
Other files are not important
- 'recycle_gift.mlx' do the exaustive search, if needed.
- 'tightfig.m' is the function that makes the figure cooler, it is invoked in 2.
- 'WattsStrogats' I have never used, it will create a different topology.
### External links
Access the Overleaf link to read my report
[Overleaf link](https://www.overleaf.com/read/wvdqhdxrfzfc)
Link to the lucidchart for the block chart [lucid chart](https://www.lucidchart.com/invitations/accept/c052cab4-5227-4052-8479-4a42bb04d734)

