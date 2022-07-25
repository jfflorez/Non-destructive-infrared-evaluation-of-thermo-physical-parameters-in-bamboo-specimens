
% Test2_BTPE (Bamboo's Thermal Properties Estimation)
% Param space: k-pc, h is kept constant

% For each bamboo sample defined in "listOfSamples", and
% For each value of h in hVec (i.e. [10 15 25]),
% this test evaluates the variation of the convergent points (optimal ones)
% as the initial guess p_init = [0.146 3] is peturbed randomly to vary up
% to 5 percent in each component. This allows us to observe
% how close or stable are the optimal points toward which LM algorithm
% converges given a initial guess (p_init). Assuming p_fit, which is the
% convergence point given p_init, the reference value, the "err" variable
% stores the relative error between p_fit and the convergence points (given
% a perturbed version of p_init). As the perturbed version of p_init varies
% up to 5 percent is expected that the relative errors do not vary more
% than 0.1 percent for p_fit to be a good convergence point according to
% [26].

path(path,'./BambooInfo')
path(path,'./Functions')
global matName h_ paramSpace;

% First half is unpreserved. Second half is preserved
listOfSamples = {'KB0_11','KB0_12','KB0_13','KB0_14','KB0_15','KB0_16','KB0_17','KB0_18','KB0_19','KB0_20',...
                 'KB1_11','KB1_12','KB1_13','KB1_14','KB1_15','KB1_16','KB1_17','KB1_18','KB1_19','KB1_20'};

% Memory allocation
ntrials  = 50;
numberOfSamples = length(listOfSamples);
p_fit    = zeros(2,ntrials,numberOfSamples);
sigma_p  = zeros(2,ntrials,numberOfSamples);
sigma_y  = zeros(720,ntrials,numberOfSamples);
Chi_sq   = zeros(numberOfSamples,ntrials);
p_init_  = zeros(2,ntrials,20);
R2       = zeros(ntrials,numberOfSamples);
Table    = [];
med_p_fit= [];
err      = zeros(2,ntrials,numberOfSamples);

% Initial guess parameters  ...
p_init = [0.33 3]';
% hVec   = [10 15 25];        % Heat transfer coefficients of air

hVec   = [15 25 35];        % Heat transfer coefficients of air

paramSpace = '2D';

% LM-algorithm Parameters
%         prnt MaxIter  eps1  eps2  epx3  eps4  lam0  lamUP lamDN UpdateType 
opts   = [  3,    50, 1e-3, 1e-3, 1e-3, 1e-2, 1e-2,    11,    9,        1 ];
p_min  = [0.1 2]';  % Lower bounds
p_max  = [0.6 10]'; % Upper bounds

for h_ = hVec

    for s = 1:length(listOfSamples)
        % Experimental Data
        matName = listOfSamples{s};
        load(matName,'T','t','center');
        [rows, cols, frames] = size(T);
        T_dat = T(center(2), center(1), :); T_dat = T_dat(:);
        weight = length(T_dat)/sqrt(T_dat'*T_dat);	  % sqrt of sum of data squared

        % 
        trials = 1;
        while trials < ntrials+1
            if trials > 1
                p_init_(:,trials,s) = randBox(p_init,0.95*p_init,1.05*p_init);
                [p_fit(:,trials,s),Chi_sq(s,trials),sigma_p(:,trials,s),sigma_y(:,trials,s),corr(:,:,trials,s),R2(trials,s),cvg_hst] =  ...
                lm('CN_solver',p_init_(:,trials,s),t,T_dat,weight,-0.0001,p_min,p_max,[],opts);
            else
                p_init_(:,trials,s) = p_init;
                [p_fit(:,trials,s),Chi_sq(s,trials),sigma_p(:,trials,s),sigma_y(:,trials,s),corr(:,:,trials,s),R2(trials,s),cvg_hst] =  ...
                lm('CN_solver',p_init_(:,trials,s),t,T_dat,weight,-0.0001,p_min,p_max,[],opts);
            end
            trials = trials + 1;
        end
        err(:,:,s) =  (repmat(p_fit(:,1,s),1,ntrials) - p_fit(:,:,s))./repmat(p_fit(:,1,s),1,ntrials);
    end
    
    save(strcat('./Results\results_Test2_BTPE_h',num2str(h_),'r0cm','.mat'),'p_init_','p_fit','sigma_p','R2','err')
end




