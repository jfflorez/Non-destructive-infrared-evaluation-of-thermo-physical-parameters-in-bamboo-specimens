function [T] = CN_solver(param)

% global paramSpace dTdr
global paramSpace

if strcmp(paramSpace,'2D')
    inputParams_2param;
elseif strcmp(paramSpace,'3D')
    inputParams_3param;
%     disp(':)')
elseif strcmp(paramSpace,'1D')
    inputParams_1param;
%     disp(':)')
end
% -------------------------------------------------------------------------

lambda_r = alpha_r*dt/(dr^2);
nr = round(W/dr);
nt = floor(tacq/dt);

T = zeros(nt,nr);
T(:,:) = T0;
T(:,1)  = reshape(Ts,nt,1);

[gostCoeffs,A] = triDiag([-lambda_r (2*lambda_r+1) -lambda_r],nr-2);
A(nr-2,nr-3:nr-2) = A(nr-2,nr-3:nr-2) + gostCoeffs(2)*[-k 4*k]/(3*k + 2*dr*h);

% A(nr-2,nr-3:nr-2) = A(nr-2,nr-3:nr-2) + gostCoeffs(2)*[-(k_h) 4*(k_h)]/(3*(k_h) + 2*dr);

for l = 1:nt-1    

    j = (2:nr-1);
    B = sum([lambda_r*(1-1./(2*((j-1) + r0/dr)));...
             -(2*lambda_r-1)*ones(1,nr-2);lambda_r*(1+1./(2*((j-1) + r0/dr)))].*[T(l,j-1);T(l,j);T(l,j+1)]);    
    B(1)    = B(1) - gostCoeffs(1)*T(l,1);
    B(nr-2) = B(nr-2) - gostCoeffs(2)*(2*dr*h*Tinf)/(3*k + 2*dr*h);
%     B(nr-2) = B(nr-2) - gostCoeffs(2)*(2*dr*Tinf)/(3*(k_h) + 2*dr);
    
    T(l+1,2:nr-1) = (A\B')';  
    T(l+1,nr) = (-k*T(l+1,nr-2) + 4*k*T(l+1,nr-1) +2*dr*h*Tinf)/(3*k + 2*dr*h);
%     T(l+1,nr) = (-(k_h)*T(l+1,nr-2) + 4*(k_h)*T(l+1,nr-1) +2*dr*Tinf)/(3*(k_h) + 2*dr);
    
    
    
end

T = T(1:5:end-4,:); % T(t,R)

% dTdr = zeros(size(T));
% dTdr(:,1) = (-T(:,3) + 4*T(:,2) - 3*T(:,1))/(2*dr);
% dTdr(:,2:end-1) = (T(:,3:end)-T(:,1:end-2))/(2*dr);
% dTdr(:,end) = (T(:,end-2) - 4*T(:,end-1) + 3*T(:,end))/(2*dr);

T = T(:,end); % T(t,R)








end