path(path,'./BambooInfo')
path(path,'./functions')
clear
% *** For this demonstration example, simulate some artificial measurements by
% *** adding random errors to the curve-fit equation.  

global matName h_ paramSpace diameter thickness_
matName = 'KB0_13';
paramSpace = '2D';
load(matName,'T','t');
[rows, cols, frames] = size(T);
diameter = 0.07;
thickness_ = 0.007;

% p_true = [0.146 10 3.5];
p_true = [0.146 3.5];
h_ = 10;
T_dat = CN_solver(p_true); Npnt = length(T_dat); % EPHeatDiffusion(p_true); Npnt = length(T_dat);
T_dat = T_dat(:) + 0.1*randn(Npnt,1);	  % add random noise

% Algorithmic Parameters
%         prnt MaxIter  eps1  eps2  epx3  eps4  lam0  lamUP lamDN UpdateType 
opts = [  3,   50,      1e-3, 1e-3, 1e-3, 1e-2, 1e-2,    11,    9,       1 ];
p_min  = [0.1 2]';
p_max  = [0.6 10]';
weight = 1;	  % sqrt of sum of data squared
consts = [];
Table1a = [];
Table1b = [];

nTrials = 100;
p_init_ = zeros(nTrials-1,2);
p_fit   = zeros(nTrials-1,2);
for h_ = [7 10 25];

    trials = 1;
    while trials < nTrials    
        p_init = randBox(p_true,0.85*p_true,1.15*p_true);
        p_init_(trials,:) = p_init;
        [p_fit(trials,:),Chi_sq,sigma_p,sigma_y,corr,R2,cvg_hst] =  ...
                    lm('CN_solver',p_init,t,T_dat,weight,-0.0001,p_min,p_max,consts,opts);
        trials = trials + 1;
    end
    err =  (repmat(p_true,nTrials-1,1) - p_fit)./repmat(p_true,nTrials-1,1);
    Table1a = [Table1a;h_,p_true,mean(p_fit),std(p_fit),100*abs(p_true-mean(p_fit))./p_true]; 
    a_t = p_true(1)./p_true(2);
    a_fit = p_fit(:,1)./p_fit(:,2);
    Table1b = [Table1b;h_,a_t ,mean(a_fit),std(a_fit),100*abs(a_t - mean(a_fit))./a_t]; 
%     save(strcat('./Results\results_Test1_synt_h',num2str(h_),'r0cm','.mat'),'p_init_','p_fit','diameter','thickness_','err')

end
