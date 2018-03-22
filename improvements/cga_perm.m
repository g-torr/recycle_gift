% Continuous Genetic Algorithm
%
% minimizes the objective function designated in ff
% Before beginning, set all the parameters in parts
% I, II, and III
% Haupt & Haupt
% 2003
clear
%_______________________________________________________
% I Setup the GA
ff='make_presents'; % objective function
n_friends=20;
npar=2*n_friends-1; % number of optimization variables
varhi=.5; varlo=n_friends+0.4999; % variable limits
%_______________________________________________________
% II Stopping criteria
maxit=10000; % max number of iterations
mincost=0.1; % minimum cost
%_______________________________________________________
% III GA parameters
popsize=20; % set population size
mutrate=.05; % set mutation rate
selection=0.5; % fraction of population kept
Nt=npar; % continuous parameter GA Nt=#variables
keep=floor(selection*popsize); % #population members that survive
nmut=ceil((popsize-1)*Nt*mutrate); % total number of mutations
M=ceil((popsize-keep)/2); % number of matings
%_______________________________________________________
% Create the initial population
iga=0; % generation counter initialized
par=zeros(popsize,npar);
for i=1:popsize
    par(i,:)=[randperm(n_friends) ceil(n_friends*rand(1,n_friends-1))]; % random
end
global neighbours
load('neighbours.mat')
if length(neighbours)~=n_friends
    error('There is a mismathc between the topology of social interaction and the problem: Please recreate the social interactions')
end
tic

%cost=feval(ff,par); % calculates population cost using ff
[rr, cc] =size(par);
for ii=1:rr
    cost(ii) = feval(ff,par(ii,:));
end




[cost,ind]=sort(cost); % min cost in element 1
par=par(ind,:); % sort continuous
minc(1)=min(cost); % minc contains min of
meanc(1)=mean(cost); % meanc contains mean of population
%_______________________________________________________
% Iterate through generations
while iga<maxit
    iga=iga+1; % increments generation counter
    %_______________________________________________________
    % Pair and mate
    M=ceil((popsize-keep)/2); % number of matings
    prob=flipud([1:keep]'/sum([1:keep])); % weights chromosomes
    odds=[0 cumsum(prob(1:keep))']; % probability distribution function
    pick1=rand(1,M); % mate #1
    pick2=rand(1,M); % mate #2
    % ma and pa contain the indicies of the chromosomes that will mate
    ic=1;
    while ic<=M
        for id=2:keep+1
            if pick1(ic)<=odds(id) & pick1(ic)>odds(id-1)
                ma(ic)=id-1;
            end
            if pick2(ic)<=odds(id) & pick2(ic)>odds(id-1)
                pa(ic)=id-1;
            end
        end
        ic=ic+1;
    end
    perm=par(:,1:n_friends);
    decision=par(:,n_friends+1:end);
    %%%%-------------------------This is the crossover and mutation for
    %%%%permutation part
    
        % Performs mating
    for ic=1:M
        mate1=perm(ma(ic),:);
        mate2=perm(pa(ic),:);
        indx=2*(ic-1)+1; % starts at one and skips every
        % other one
        xp=ceil(rand*n_friends); % random value between 1 and N. It is the crossover point
        temp=mate1;
        x0=xp;
% I do cyclic crossover. I swap the genes at the crossover point 
        mate1(xp)=mate2(xp);% 
        mate2(xp)=temp(xp);
        xs=find(temp==mate1(xp));% I find the index of the gene ( on mate1) that is equal to the newly  swapped gene 
        xp=xs;% this is the point on mate1 where I have the overlap

       while (xp)~=(x0)% if the overlap is with x0, it means that I put on mate1 the gene that in the first swap I have moved to mate2
            mate1(xp)=mate2(xp);
            mate2(xp)=temp(xp);
            xs=find(temp==mate1(xp));
            xp=xs;% this is the cycle crossover
        end% it ends when I do as many crossover as it needs to have again in the mate1 the gene that was exchanged in the first swap with mate2.  This condition will guaratee that both chromosomes contains all the elements. 
        perm(keep+indx,:)=mate1;
        perm(keep+indx+1,:)=mate2;
    end
    %_______________________________________________________
    % Mutate the population
    nmut=ceil(popsize*n_friends*mutrate);
    for ic = 1:nmut
        row1=ceil(rand*(popsize-1))+1;
        col1=ceil(rand*n_friends);
        col2=ceil(rand*n_friends);
        % I add the following 3 line in order to perform  mutation using
        % reciprocal exchange, otherwise it doesn't seem to perform
        % mutations...
        swp=perm(row1,col1);
        perm(row1,col1)=perm(row1,col2);
        perm(row1,col2)=swp;
    end

    %%%%%%-----------------------END of permutation
    
    
    
    %_______________________________________________________
    % Performs mating using single point crossover
    ix=1:2:keep; % index of mate #1
    xp=ceil(rand(1,M)*(n_friends-1)); % crossover point
    r=rand(1,M); % mixing parameter
    for ic=1:M
        xy=decision(ma(ic),xp(ic))-decision(pa(ic),xp(ic)); % ma and pa
        % mate
        decision(keep+ix(ic),:)=decision(ma(ic),:); % 1st offspring
        decision(keep+ix(ic)+1,:)=decision(pa(ic),:); % 2nd offspring
        decision(keep+ix(ic),xp(ic))=decision(ma(ic),xp(ic))-r(ic).*xy;
        % 1st
        decision(keep+ix(ic)+1,xp(ic))=decision(pa(ic),xp(ic))+r(ic).*xy;
        % 2nd
        if xp(ic)<n_friends-1 % crossover when last variable not selected
            decision(keep+ix(ic),:)=[decision(keep+ix(ic),1:xp(ic)) decision(keep+ix(ic)+1,xp(ic)+1:n_friends-1)];
            decision(keep+ix(ic)+1,:)=[decision(keep+ix(ic)+1,1:xp(ic)) decision(keep+ix(ic),xp(ic)+1:n_friends-1)];
        end % if
    end
    %_______________________________________________________
    % Mutate the population
    mrow=sort(ceil(rand(1,nmut)*(popsize-1))+1);
    mcol=ceil(rand(1,nmut)*(n_friends-1));
    for ii=1:nmut
        decision(mrow(ii),mcol(ii))=(varhi-varlo)*rand+varlo;
        % mutation
    end % ii
    %_______________________________________________________
    % The new offspring and mutated chromosomes are evaluated
    %cost=feval(ff,par);
    par=[perm decision];
    [rr, cc] =size(par);
    for ii=2:rr
        cost(ii) = feval(ff,par(ii,:));
    end
    
    
    
    
    
    %_______________________________________________________
    % Sort the costs and associated parameters
    [cost,ind]=sort(cost);
    par=par(ind,:);
    %_______________________________________________________
    % Do statistics for a single nonaveraging run
    minc(iga+1)=min(cost);
    meanc(iga+1)=mean(cost);
    %_______________________________________________________
    % Stopping criteria
    if iga>maxit | cost(1)<mincost
        break
    end
    [iga cost(1)];
end %iga
toc
%_______________________________________________________
% Displays the output
day=clock;
disp(datestr(datenum(day(1),day(2),day(3),day(4),day(5),day(6)),0))
disp(['optimized function is ' ff])
format short g
disp(['popsize = ' num2str(popsize) ' mutrate = ' num2str(mutrate) ' # par = ' num2str(npar)])
disp(['#generations=' num2str(iga) ' best cost=' num2str(cost(1))])
disp(['best solution'])
disp([num2str(par(1,:))])
disp('continuous genetic algorithm')
figure(24)
iters=0:length(minc)-1;
plot(iters,minc,iters,meanc,'-');
xlabel('generation');ylabel('cost');
title(['Continuous Genetic Algorithm; Function: ' ff]);
%text(0,minc(1),'best');text(1,minc(2),'population average')
legend('best', 'population average');