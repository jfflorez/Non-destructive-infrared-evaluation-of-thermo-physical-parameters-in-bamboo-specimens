function [Jb,Jc,t] = sensMatComp(func,y,t,p,dp)

% y  = feval(func,p)
m = length(y);
n = length(p);

Jc = zeros(m,n);
Jb = zeros(m,n);
for i = 1:n    
    delta = zeros(size(p));
    delta(i) = dp;  
    Jc(:,i) = (feval(func,p + delta)-feval(func,p - delta))/(2*dp);  
    Jb(:,i) = (feval(func,p + delta)-y)/(dp);
end








end