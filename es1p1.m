clear 
%f: the name of function describes the minimisation problem
%init: initial vector of the individual
%sigma: initial value of the strategry parameter
%ite: number of iterations
n_friends=8;
npar=2*n_friends-1; % number of optimization variables
global neighbours
load('neighbours.mat')
f='make_presents';
ite=30000;%number of iteration
sigma=1;
varlo=.5; varhi=n_friends+0.4999; % variable limits
if length(neighbours)~=n_friends
    error('There is a mismathc between the topology of social interaction and the problem: Please recreate the social interactions')
end

%-----------start iterations---------
best_costs=zeros(10,1);
for iteration=1:10
    tic
    x = [ceil(n_friends*rand(1,2*n_friends-1))]; % random initialisation;
    n = length(x);
    k = 1;

    while (k <= ite)
        while(true)
            y = x + sigma.*randn(1,n);    % create mutated solution 'y'
            if (y<varhi)&(y>varlo)
                break
            end
        end
        fx = feval(f,x);              % evaluate function with 'x'
        fy = feval(f,y);              % evaluate function with mutated solution 'y'
        if (fy < fx)
            x = y;                      % update individual
        end
        k = k+1;                      % update counter
    end
    best_costs(iteration)=feval(f,x);
    toc
end