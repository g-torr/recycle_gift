function neighbours = create_social_interactions(n_friends)
close
% This funtion creates the social network of who knows who.
%   Considering the total number of friends as n_friends, each of them can have n_neighbours friends. Who are the new friends is stored in a cell of n_friends  
n_neighbours=ceil(n_friends*0.5*(1+rand(n_friends,1)))% each node can have any number of neighbours,from an uniform distributon of integers till n_friends
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
p.NodeLabel = {};
p.ArrowSize=22;
p.LineWidth=1.5;
% Custom labels
hold on
names=string(1:n_friends);
%for i=1:length(names)
%    text(p.XData(i), p.YData(i), names(i), 'FontSize', 18);
%end
ax=gca();
ax.Visible= 'off';
tightfig()
saveas(gcf,'friendship.png')
hold off

G2=digraph(NF);
p2=plot(G2,'Layout','circle');
p2.NodeLabel = {};
p2.ArrowSize=22;
p2.LineWidth=1.5;
% Custom labels
hold on
names=string(1:n_friends);
%for i=1:length(names)
%    text(p2.XData(i), p2.YData(i), names(i), 'FontSize', 18);
%end
ax=gca();
ax.Visible= 'off';
tightfig()
print(gcf,'non-friendship','-dpng')
end


