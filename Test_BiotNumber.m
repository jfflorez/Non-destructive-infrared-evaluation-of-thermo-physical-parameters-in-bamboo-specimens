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

k_min  = 0.1; k_max = 0.6;
pc_min = 2;   pc_max = 10;
h_min  = 2;   h_max = 50;


h  = h_min:(h_max-h_min)/48:h_max;
k  = k_min:(k_max-k_min)/10:k_max;
pc = pc_min;%:(pc_max-pc_min)/16:pc_max;

% T_hk = zeros(length(h),length(k),length(pc));
T_hk = [];
for z = 1:length(pc)
    z
    for i = 1:length(h)
        T_R = [];
        for j = [1 3 5 7 9 10]%[3 4 5 10 15 20 25]
            j
            h_ = h(i);
            T_dat = CN_solver([k(j) pc(z)]);
            T_R = [T_R,T_dat(end)];
        end
        T_hk = [T_hk;T_R];
    end
end

figure(1)
hold on;
plot(h,T_hk(:,1),'--k')
plot(h,T_hk(:,2),'-*b')
plot(h,T_hk(:,3),'-ob')
plot(h,T_hk(:,4),'-sy')
plot(h,T_hk(:,5),'->g')
plot(h,T_hk(:,6),'-+r')

legend(strcat('k=',num2str(k(1))),...
       strcat('k=',num2str(k(3))),...
       strcat('k=',num2str(k(5))),...
       strcat('k=',num2str(k(7))),...
       strcat('k=',num2str(k(9))),...
       strcat('k=',num2str(k(10))))
xlabel('$h \ \left[ W/m^2K\right]$ ','interpreter','latex')
ylabel('$ T(R) \left[ ^\circ C \right]$','interpreter','latex')

figure(2)
hold on;
plot(h,h*0.5*diameter./k(1) ,'--k')
plot(h,h*0.5*diameter./k(3) ,'-*b')
plot(h,h*0.5*diameter./k(5) ,'-ob')
plot(h,h*0.5*diameter./k(7),'-sy')
plot(h,h*0.5*diameter./k(9),'->g')
plot(h,h*0.5*diameter./k(10),'-+r')

legend(strcat('k=',num2str(k(1))),...
       strcat('k=',num2str(k(3))),...
       strcat('k=',num2str(k(5))),...
       strcat('k=',num2str(k(7))),...
       strcat('k=',num2str(k(9))),...
       strcat('k=',num2str(k(10))))
xlabel('$h \ \left[ W/m^2K\right]$ ','interpreter','latex')
ylabel('Biot Number $(hR/k)$','interpreter','latex')
