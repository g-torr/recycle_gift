close
load neighbours.mat
n_friends=length(neighbours);
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
for i=1:length(names)
    text(p.XData(i), p.YData(i), names(i), 'FontSize', 18);
end
ax=gca();
ax.Visible= 'off';
tightfig()
saveas(gcf,'friendship.png')
hold off

G1=digraph(NF);
p1=plot(G1,'Layout','circle');
p1.NodeLabel = {};
p1.ArrowSize=22;
p1.LineWidth=1.5;
% Custom labels
hold on
names=string(1:n_friends);
for i=1:length(names)
    text(p1.XData(i), p1.YData(i), names(i), 'FontSize', 18);
end
ax=gca();
ax.Visible= 'off';
tightfig()
print(gcf,'non-friendship','-dpng')
hold off


flippedNF=NF';
G2=digraph(flippedNF);
p2=plot(G2,'Layout','circle');
p2.NodeLabel = {};
p2.ArrowSize=22;
p2.LineWidth=1.5;
highlight(p2,[17,2,14,15,16,13,8,6,1,20,12,18,4,10,11,7,19,3,9,5],'NodeColor','green','EdgeColor','red')
% Custom labels
hold on
names=string(1:n_friends);
for i=1:length(names)
    text(p2.XData(i), p2.YData(i), names(i), 'FontSize', 18);
end

ax=gca();
ax.Visible= 'off';
tightfig()
print(gcf,'flipped_non-friendship','-dpng')
hold off