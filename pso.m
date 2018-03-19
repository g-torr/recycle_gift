% Particle Swarm Optimization - PSO
% Haupt & Haupt
% 2003
clear
ff = 'make_presents'; % Objective Function
% Initializing variables
popsize = 100; % Size of the swarm
n_friends=8;
npar=2*n_friends-1; % number of optimization variables
maxit = 1000; % Maximum number of iterations
global neighbours
load('neighbours.mat')
if length(neighbours)~=n_friends
    error('There is a mismathc between the topology of social interaction and the problem: Please recreate the social interactions')
end
% periodic boundary condition are implemented
c1 = 1; % cognitive parameter
c2 = 4-c1; % social parameter

C=1; % constriction factor
% Initializing swarm and velocities
par=rand(popsize,npar); % random population of continuous values
vel = rand(popsize,npar); % random velocities
% Evaluate initial population
% cost=feval(ff,par) % calculates population cost using ff

[rr, cc] =size(par);
for ii=1:rr
    cost(ii) = feval(ff,par(ii,:));
end

minc(1)=min(cost); % min cost
meanc(1)=mean(cost); % mean cost
globalmin=minc(1); % initialize global minimum 
% Initialize local minimum for each particle
localpar = par; % location of local minima
localcost = cost; % cost of local minima
% Finding best particle in initial population
[globalcost,indx] = min(cost);
globalpar=par(indx,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start iterations
iter = 0; % counter
while iter < maxit
    iter = iter + 1;
    % update velocity = vel
    w=(maxit-iter)/maxit; %inertia weiindxht
    r1 = rand(popsize,npar); % random numbers
    r2 = rand(popsize,npar); % random numbers
    vel = C*(w*vel + c1 *r1.*(localpar-par) + c2*r2.*(ones(popsize,1)*globalpar-par));
    % update particle positions
    par = par + vel; % updates particle position
%     overlimit=par<=1;
%     underlimit=par>=0;
%     par=par.*overlimit+not(overlimit);
%     par=par.*underlimit;
    
    % i implemented the periodic boundary conditions, points lay in the
    % [0.5,n_friends+0.5] range
   par = mod(par-0.5,n_friends)+0.5;
    % Evaluate the new swarm
    %cost = feval(ff,par); % evaluates cost of swarm
    [rr, cc] =size(par);
    for ii=1:rr
        cost(ii) = feval(ff,par(ii,:));
    end
    
% Updating the best local position for each particle
    bettercost = cost < localcost;% check if individuals  in the population have improved their record of best cost
    localcost = localcost.*not(bettercost) + cost.*bettercost; % if this is the case, for each individue it update the best cost to the actual one, otherwise it keeps as it was before
    localpar(find(bettercost),:) = par(find(bettercost),:); % also update the best  solution for the individue
    % Updating index g
    [temp, t] = min(localcost);
    if temp<globalcost
        globalpar=par(t,:); indx=t; globalcost=temp;
    end
    %[iter globalpar globalcost] % print output each iteration
    %disp(['Iteration',num2str(iter),' best cost',num2str(globalcost)]) 
    minc(iter+1)=min(cost); % min for this iteration
    globalmin(iter+1)=globalcost; % best min so far
    meanc(iter+1)=mean(cost); % avg. cost for this iteration
end% while

figure(24)
iters=0:length(minc)-1;
plot(iters,minc,iters,meanc,'-',iters,globalmin,':');
xlabel('generation');ylabel('cost');
text(0,minc(1),'best');text(1,minc(2),'population average')

globalpar