function neighbours = create_social_interactions(n_friends)
close
% This funtion creates the social network of who knows who.
%   Considering the total number of friends as n_friends, each of them can have n_neighbours friends. Who are the new friends is stored in a cell of n_friends  
n_neighbours=ones(n_friends,1)*round(n_friends*0.8);%ceil(n_friends*0.5*(1+rand(n_friends,1)))% each node can have any number of neighbours,from an uniform distributon of integers till n_friends
disp(['the mean connectivity is',num2str(mean(n_neighbours)/n_friends)])
neighbours=cell(n_friends,1);
for i=1:n_friends
    neighbours{i} = randperm(n_friends,n_neighbours(i)); %take randomly n_neighbours as friends and add itself
end
save('neighbours.mat','neighbours');
%plot the grah
F=zeros(n_friends);
for i=1:n_friends
    F(i,neighbours{i})=1;% this is the network of social frienship
end
NF=~F;% network of who does not know who
F=F-diag(diag(F));
NF=NF-diag(diag(NF));

G=digraph(F);
p=plot(G,'Layout','circle');

figure()
G2=digraph(NF);
p2=plot(G2,'Layout','circle');
end


