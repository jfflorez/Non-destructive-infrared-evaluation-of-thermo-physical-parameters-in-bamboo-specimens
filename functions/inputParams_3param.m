

% 3-D parameter optimization space, k-h-pc space
% Define the input parameters and constants for the CN_solver that solves
% Eq. (1) in the paper "Estimation of thermo-physical properties ...
% of bamboo culms by using thermal imaging and non-linear least squares".
% The opt. parameter vector is p_t = [k,h,pc].

global matName;
load(matName,'Ts','ts','thickness','D','b','a');

% TIME AND SPATIAL DOMAIN 
H    = 15;   % cm
W    = mean(thickness)*100;   % cm

% TIME AND SPATIAL STEPS
nr = 20;
nt = length(Ts);
dr = W/nr; % cm
dz = H/10; % cm
dt = ts/5; % s
tacq = length(Ts)*dt;

% BAMBOO THERMAL PROPERTIES
% k     = param(1)*ones(1,nr); % 0.16 W/m°c - thermal conductivity
k     = param(1); % 0.16 W/m°c - thermal conductivity
pc    = param(2)*(10^6);
alpha_r = k/pc; % m^2/s - thermal diffusivity
alpha_z = k/pc;

% -------------------------------------------------------------------------
k     = k/100;
alpha_r = alpha_r*1e4;
alpha_z = alpha_z*1e4;
% -------------------------------------------------------------------------
% SURFACE TEMPERATURE OF THE RESISTANCE (HEAT SOURCE)
% b = [param(1) param(2)];
% a = [param(3) param(4)];
Ts = filter(b,a,Ts-min(Ts)) + min(Ts);
% figure, plot(Ts)
T0 = min(Ts);
r0 = (0.5*mean(D) - mean(thickness))*100; % inner radius

% AIR THERMAL PROPERTIES
h = param(3)*1e-4;
Tinf = min(Ts); % air temperature

