function [cost,gift_owned,gifted] =make_presents(state)
    global neighbours
    state=round(state);
    % state is a vectors which contains n_friends+ (n_friends-1) variables
    n_friends=(length(state)+1)/2;
    x=state(1:n_friends); %these are the first n_friends, and they represents the people I visit
    if (length(unique(x))<n_friends)% we want to go to all friends, so I penalise heavily if not do so
        cost=n_friends^2;
        return;
    end
    decision=state(n_friends:end)-0.5;% this variable says, when I can choose among different presents  (i.e. in the else below) which present I gift. It has not effect in the ''if'' case below. But in general I cannot predict a priori if it is needed or not.
    decision=decision/n_friends; % I want it normalised between [0,1]
    cost=1; % in the first step I need to buy a presents, 
    gift_owned=x(1);% I receive the gift from the first friend
    gifted=zeros(n_friends,1);% this is just for record of which  gifth are given to friends, it is not used in the evalutation of the cost. 0 means that the gifth is buyed, otherwise it says from which person the gift comes from 
    for i=2:n_friends
        indeces=find(~ismember(gift_owned,neighbours{x(i)})); % gives the indeces of the presents that can be gifted
        if  isempty(indeces) % given the presents I have, all of them  would be spotted by the receiver
            cost=cost+1;
            gift_owned(end +1)=x(i);
        else
            %index of the selected gifth is:
            indx=indeces(ceil(decision(i-1)*length(indeces)));% I pick one gift among the list of possibles( i.e. that do not clash with social relations). To do so I use pick one of the indices according to the number decision.  
            gifted(i)=gift_owned(indx);% this is the gift I  make to x(i)
            gift_owned(indx)=x(i); % I receive the gift
        end
    %gift_owned
    %gifted    
    end
end
