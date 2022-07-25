
% 2-D parameter optimization space, k-pc space
% Define the input parameters and constants for the CN_solver that solves
% Eq. (1) in the paper "Estimation of thermo-physical properties ...
% of bamboo culms by using thermal imaging and non-linear least squares".
% The opt. parameter vector is p_t = [k,pc] and h is kept constant.

global matName h_;
load(matName,'Ts','ts','thickness','D','b','a');

% BAMBOO THERMAL PROPERTIES
k     = param(1); % 0.16 W/m°c - thermal conductivity
pc    = param(2)*(10^6);
alpha_r = k/pc; % m^2/s - thermal diffusivity
% -------------------------------------------------------------------------
k     = k/100;
alpha_r = alpha_r*1e4; %[cm^2/s];
% -------------------------------------------------------------------------
% SURFACE TEMPERATURE OF THE RESISTANCE (HEAT SOURCE)
% b = [param(1) param(2)];
% a = [param(3) param(4)];
Ts = filter(b,a,Ts-min(Ts)) + min(Ts);
% figure, plot(Ts)
T0 = min(Ts);
r0 = (0.5*mean(D) - mean(thickness))*100; % inner radius [cm]
% r0 = (0.5*diameter - thickness_); % inner radius [m]

% AIR THERMAL PROPERTIES
% h = param(2)*1e-4;
% h = 15*1e-4;
h = h_*1e-4; % [W/(m^2)K] * (1m/100cm)^2
Tinf = min(Ts); % air temperature

% TIME AND SPATIAL DOMAIN 
H    = 15;   % cm
W    = mean(thickness)*100;   % [cm]

% TIME AND SPATIAL STEPS
dr = W/20; % cm
dt = ts/5; % s
tacq = length(Ts)*dt;