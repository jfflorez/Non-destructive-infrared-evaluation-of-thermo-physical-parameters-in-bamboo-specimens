path(path,'./BambooInfo')
path(path,'./functions')
close all
global matName paramSpace dTdr;

matName = 'KB0_11';
paramSpace = '3D';
load(matName,'t');

% p = [0.116 10 3.5;
%      0.146 10 3.5;
%      0.176 10 3.5];
% j = 1;
p = [0.146 3 10;
     0.146 3 15;
     0.146 3 25];
j = 2;
% p = [0.146 10 3.5;
%      0.146 10 5.5;
%      0.146 10 7.5];
% j = 3;

varParam = {'k=','h=','\rhoc_p ='};
symbs = {'-','-','-','--.','-o'};
for i = 1:3
T_dat = CN_solver(p(i,:)); Npnt = length(T_dat); 
dp = 0.00001;
[Jb,Jc,t] = sensMatComp('CN_solver',T_dat,t,p(i,:),dp);

figure(1);
if i == 1
    hold on
    plot(t(1:10:end),p(i,1)*Jc(1:10:end,1),strcat(symbs{1},'b'))
    plot(t(1:10:end),p(i,3)*Jc(1:10:end,3),strcat(symbs{3},'g'))
    plot(t(1:10:end),p(i,2)*Jc(1:10:end,2),strcat(symbs{2},'r'))
elseif i == 2
    plot(t(1:10:end),p(i,1)*Jc(1:10:end,1),strcat(symbs{4},'b'))
    plot(t(1:10:end),p(i,3)*Jc(1:10:end,3),strcat(symbs{4},'g'))
    plot(t(1:10:end),p(i,2)*Jc(1:10:end,2),strcat(symbs{4},'r'))
else
    plot(t(1:10:end),p(i,1)*Jc(1:10:end,1),strcat(symbs{5},'b'))
    plot(t(1:10:end),p(i,3)*Jc(1:10:end,3),strcat(symbs{5},'g'))
    plot(t(1:10:end),p(i,2)*Jc(1:10:end,2),strcat(symbs{5},'r'))
end
end

figure(1);
legend('k J_k, k=0.146','\rhoc_p J_{\rhoc_p}, \rhoc_p=3\times10^6','h J_h, h=10','Location','Best')
xlabel('t [s]')
ylabel('Sens. Coeff.')
xlim([t(1) t(end)])

figure(2)
hold on, 
plot(t(1:10:end),dTdr(1:10:end,1),'-.k')
plot(t(1:10:end),dTdr(1:10:end,10),'-+g')
plot(t(1:10:end),dTdr(1:10:end,20),'-ob')
legend('r=r_0','r=(R-r_0)/2','r=R','Location','Best')
xlabel('t [s]')
ylabel('Sens. Coeff. J_r')
xlim([t(1) t(end)])
% figure(1);
% legend(strcat(varParam{j},num2str(p(1,j))),strcat(varParam{j},num2str(p(2,j))),...
%               strcat(varParam{j},num2str(p(3,j))),'Location','Best')
% figure(1);
% legend(strcat(varParam{j},num2str(p(1,j))),strcat(varParam{j},num2str(p(2,j))),...
%               strcat(varParam{j},num2str(p(3,j))),'Location','Best')
%%%%%%%%%%%%%%%%
% path(path,'./BambooInfo')
% close all
% global matName;
% 
% matName = 'KB0_11';
% 
% load(matName,'t');
% 
% % p = [0.116 10 3.5;
% %      0.146 10 3.5;
% %      0.176 10 3.5];
% % j = 1;
% % p = [0.146 5  3.5;
% %      0.146 10 3.5;
% %      0.146 15 3.5];
% % j = 2;
% p = [0.146 10 3.5;
%      0.146 10 5.5;
%      0.146 10 7.5];
% j = 3;
% 
% varParam = {'k=','h=','\rhoc_p ='};
% symbs = {'-+','-o','-.'};
% for i = 1:3
% T_dat = CN_solver(p(i,:)); Npnt = length(T_dat); 
% dp = 0.00001;
% [Jb,Jc,t] = sensMatComp('CN_solver',T_dat,t,p(i,:),dp);
% 
% Jk = figure(1);
% plot(t(1:10:end),p(i,1)*Jc(1:10:end,1),strcat(symbs{i},'b'))
% xlabel('t [s]')
% ylabel('J_{k}')
% xlim([t(1) t(end)])
% hold on
% 
% % Jh = figure(2);
% plot(t(1:10:end),p(i,2)*Jc(1:10:end,2),strcat(symbs{i},'r'))
% xlabel('t [s]')
% ylabel('J_{h}')
% xlim([t(1) t(end)])
% hold on
% 
% % Jpc = figure(3);
% plot(t(1:10:end),p(i,3)*Jc(1:10:end,3),strcat(symbs{i},'g'))
% xlabel('t [s]')
% ylabel('J_{\rho c_p}')
% xlim([t(1) t(end)])
% hold on
% end
% 
% Jk = figure(1);
% legend(strcat(varParam{j},num2str(p(1,j))),strcat(varParam{j},num2str(p(2,j))),...
%               strcat(varParam{j},num2str(p(3,j))),'Location','Best')
% Jh = figure(2);
% legend(strcat(varParam{j},num2str(p(1,j))),strcat(varParam{j},num2str(p(2,j))),...
%               strcat(varParam{j},num2str(p(3,j))),'Location','Best')
% Jpc= figure(3);
% legend(strcat(varParam{j},num2str(p(1,j))),strcat(varParam{j},num2str(p(2,j))),...
%               strcat(varParam{j},num2str(p(3,j))),'Location','Best')
          
% epsPrinter('Jk_kVar',Jk)
% epsPrinter('Jh_kVar',Jh)
% epsPrinter('Jpc_kVar',Jpc)
% epsPrinter('Jk_hVar',Jk)
% epsPrinter('Jh_hVar',Jh)
% epsPrinter('Jpc_hVar',Jpc)
% epsPrinter('Jk_pckVar',Jk)
% epsPrinter('Jh_pcVar',Jh)
% epsPrinter('Jpc_pcVar',Jpc)

