function X_list=Gillespie_linear_feedback_v4(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, A,repeat_time)
%% Simultaneous production with various parameters

%% Parameter setting

delay_alpha=1/delay_cv^2;
delay_beta=delay_mean*delay_cv^2;

%% Simulation details
% repeat_time=1;
t=0;
max_t=150000;
max_n=300000;
max_iter=3e8;
time_step=max_t/max_n;

% Gillespie algorithm volume
vol=1;

N=4; % Number molecules of each species
%         (1: cyto protein(hypo),
%          2: peri protein (hypo) 3: peri protein (phosphorylated)
%          4: nucleus protein )

% Matrix storing time series data
X_list=NaN(max_n, N+1,repeat_time); % column 1 : time / column 2-6 : number of molecules


%% Stochastic Simulation with Gillespie Algorithm

lambda_d_phos=lambda_d*phos_deg_ratio;

parfor repeat_i=1:repeat_time
    if mod(repeat_i,10)==0
        disp(repeat_i)
    end
    
    % presampling of random numbers
    rng(repeat_i)
    r1_list=rand(max_iter,1); % time update
    r2_list=rand(max_iter,1); % reaction selection
    
    entry_time_list=[];

    stack_time = [];
    
    % Initiation of each cycle
    iter=1;
    time_index=1;
    t=0;
    temp_entry_num=0;
    
    x=zeros(N,1); % temporal amount of species
    temp_X_list=NaN(max_n, N+1); % temporal recording


    % stoichiometric matrix (moved from the upper part of the code because of broadcasting issue)
    stch_matrix=[1,0,0,0;   0,-1,1,0;0,1,-1,0;0,0,-1,1];
    stch_matrix=[stch_matrix; -1*eye(4)];
    stch_matrix=stch_matrix';
    movement_matrix=[-1,1,0,0]';
    %%
    while (t<max_t)&&(iter<max_iter)
        

        prop_vector=zeros(1,8);
        prop_vector(1) = lambda_p*max(1-x(4)/A,0); % Protien production
        prop_vector(2) = phos(x(2:3),1,1,vol); % protein phosphorylation at peri
        prop_vector(3) = dephos(x(2:3),1,vol); % protein dephophorylation at peri
        prop_vector(4)=lambda_n*x(3);
    
        prop_vector(5)=lambda_d*x(1); % degradation of protein in cytoplasm
        prop_vector(6)=lambda_d*x(2); % degradation of protein in perinucleus(unphos)
        prop_vector(7)=lambda_d_phos*x(3); % degradation of protein in perinucleus(phos)
        prop_vector(8)=lambda_d_phos*x(4); % degradation of protein in nucleus
        
        if x(2)==0
            prop_vector(2)=0;
        end
        
        if x(3)==0
            prop_vector(3)=0;
        end
        
        tot_prop=sum(prop_vector);
        
        % propensity normalization
        for rxn=1:length(prop_vector)
            prop_vector(rxn)=prop_vector(rxn)/tot_prop;
        end
        
        prop_cumsum=cumsum(prop_vector);
                
        time_update1=t-1/tot_prop*log(r2_list(iter));
        
        [stack_time,stack_order] = sort(stack_time);
        
        if isempty(stack_time)
            time_update2=Inf;
        else
            time_update2=stack_time(1);
        end
        
        if time_update1>=time_update2
            
            if ~isempty(stack_time)
                x=x+movement_matrix(:,1);
                if length(stack_time) == 1
                    stack_time = [];
                else
                    stack_time = stack_time(2:end);
                end
            end
            
            t=time_update2;
            
        else
            
            
            % Decide which rxn to occur
            rxn_num=sum(prop_cumsum< r1_list(iter))+1;
            if rxn_num==1
                x(1)=x(1)+1;
                temp_delay=gamrnd(delay_alpha, delay_beta);
                stack_time=[stack_time, time_update1+temp_delay];
  
            elseif rxn_num==4
                entry_time_list=[entry_time_list; t];
                x(3)=x(3)-1;
                x(4)=x(4)+1;
            elseif rxn_num==5
                x(1)=x(1)-1;
                temp_ind=randsample(find(stack_time),1);
                stack_time(temp_ind)=[];
                               
            else
                x=x+stch_matrix(:,rxn_num);
            end
            
            % check nonnegativeness of particle number
            for i=1:N
                if floor(x(i))<=0
                    x(i)=0;
                end
            end
            
            t=time_update1;
        end
        
        % coarse time recording
        if (t>=time_step*time_index)
            temp_X_list(time_index,1)=t;
            temp_X_list(time_index,2:end)=x';
            %             temp_degradation_list(time_index, 1)=deg_num;
            time_index=time_index+1;
            
        end
        
        % updated iteration number
        iter=iter+1;
    end
    X_list(:,:,repeat_i)=temp_X_list;
end


end

function propensity=phos(x, K,scale,vol)
% x: number molecules of each species
NP=x(1)/vol;
HP=x(2)/vol;
% n=30;
T=NP+HP;
% y=HP/T;


if T==0
    propensity=0;
else
    propensity=0.7*T;
    %     propensity
end
propensity=max(propensity,0);


propensity=propensity*vol; % conversion of dimension to (number of particles)
propensity=scale*propensity;
end

function propensity=dephos(x, scale,vol)
NP=x(1)/vol;
HP=x(2)/vol;
T=NP+HP;
% y=HP/T;
if T==0
    propensity=0;
else
    propensity=HP*vol; % conversion of dimension to (number of particles)
    
end
propensity=scale*propensity;
end
