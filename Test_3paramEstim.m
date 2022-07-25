path(path,'./BambooInfo')
path(path,'./Functions')
global matName paramSpace;

% First half is unpreserved. Second half is preserved
listOfSamples = {'KB0_11','KB0_12','KB0_13','KB0_14','KB0_15','KB0_16','KB0_17','KB0_18','KB0_19','KB0_20',...
                 'KB1_11','KB1_12','KB1_13','KB1_14','KB1_15','KB1_16','KB1_17','KB1_18','KB1_19','KB1_20'};

% Memory allocation
ntrials  = 100;
numberOfSamples = 1;
p_fit    = zeros(3,ntrials,numberOfSamples);
sigma_p  = zeros(3,ntrials,numberOfSamples);
sigma_y  = zeros(720,ntrials,numberOfSamples);
Chi_sq   = zeros(numberOfSamples,ntrials);
p_init_  = zeros(3,ntrials,20);
R2       = zeros(ntrials,numberOfSamples);
Table    = [];
med_p_fit= [];
err      = zeros(3,ntrials,numberOfSamples);

% Initial guess parameters  ...
p_true = [0.146 3.5 10];
h_ = 10;
matName = listOfSamples{5};
load(matName,'T','t');
T_dat = CN_solver(p_true); Npnt = length(T_dat); % EPHeatDiffusion(p_true); Npnt = length(T_dat);
T_dat = T_dat(:) + 0.1*randn(Npnt,1);	  % add random noise
weight = length(T_dat)/sqrt(T_dat'*T_dat);	  % sqrt of sum of data squared

paramSpace = '3D';

% LM-algorithm Parameters
%         prnt MaxIter  eps1  eps2  epx3  eps4  lam0  lamUP lamDN UpdateType 
opts   = [  3,    50, 1e-3, 1e-3, 1e-3, 1e-2, 1e-2,    11,    9,        1 ];
p_min  = [0.1 2 2]';  % Lower bounds
p_max  = [0.6 10 25]'; % Upper bounds




% 
trials = 1;
while trials < ntrials+1
    if trials > 1
        p_init_(:,trials) = randBox(p_true,0.6*p_true,1.4*p_true);
        [p_fit(:,trials),Chi_sq(trials),sigma_p(:,trials),sigma_y(:,trials),corr(:,:,trials),R2(trials),cvg_hst] =  ...
        lm('CN_solver',p_init_(:,trials),t,T_dat,weight,-0.0001,p_min,p_max,[],opts);
    else
        p_init_(:,trials) = p_true;
        [p_fit(:,trials),Chi_sq(trials),sigma_p(:,trials),sigma_y(:,trials),corr(:,:,trials),R2(trials),cvg_hst] =  ...
        lm('CN_solver',p_init_(:,trials),t,T_dat,weight,-0.0001,p_min,p_max,[],opts);
    end
    trials = trials + 1;
end
err =  (repmat(p_fit(:,1),1,ntrials) - p_fit(:,:))./repmat(p_fit(:,1),1,ntrials);

figure(1)
plot3(p_init_(1,2:end),p_init_(2,2:end),p_init_(3,2:end),'.b'); hold on
plot3(p_init_(1,1),p_init_(2,1),p_init_(3,1),'xr')

figure(2)
plot3(p_fit(1,2:end),p_fit(2,2:end),p_fit(3,2:end),'.b'); hold on
plot3(p_fit(1,1),p_fit(2,1),p_fit(3,1),'xr')



