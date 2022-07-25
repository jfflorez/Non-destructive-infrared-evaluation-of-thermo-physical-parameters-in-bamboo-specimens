function [Table_unp,Table_p,f11,f12,f21,f22,f8a,f8b] = Test2_ResultsPresentation


path(path,'./results')
path(path,'./functions')
close all,
% clear all,

h         = [15 25 35];
symbols   = {'-ok','-+b','-sqr'};
Table_unp = [];
Table_p   = [];
for i = 1:3
% loadFile = strcat('results_Test2_BTPE_h',num2str(h(i)));
loadFile = strcat('results_Test2_BTPE_h',num2str(h(i)),'r0cm');
load(loadFile,'p_fit','p_init_','sigma_p','R2');

p_fit_avg   = reshape(mean(p_fit,2)  ,2,20);

p_init_avg  = reshape(mean(p_init_,2),2,20);
sigma_p_avg = reshape(mean(sigma_p,2),2,20);
R2_avg      = mean(R2,1);

Table_unp = [Table_unp; h(i) mean(p_fit_avg(:,1:10) ,2)' mean(sigma_p_avg(:,1:10) ,2)' mean(R2_avg(1:10))];
Table_p   = [Table_p;   h(i) mean(p_fit_avg(:,11:20),2)' mean(sigma_p_avg(:,11:20),2)' mean(R2_avg(11:20))];
              
f11 = figure(1);
hold on
plot(p_fit_avg(1,1:10),symbols{i})

f12 = figure(2);
hold on
plot(p_fit_avg(2,1:10),symbols{i})

f21 = figure(3);
hold on
plot(p_fit_avg(1,11:20),symbols{i})
f22 = figure(4);
hold on
plot(p_fit_avg(2,11:20),symbols{i})

f1 = figure(5);
hold on
sigma_unpre = p_fit_avg(1,1:10)./p_fit_avg(2,1:10);
plot(sigma_unpre,symbols{i})

f2 = figure(6);
hold on
sigma_pre = p_fit_avg(1,11:20)./p_fit_avg(2,11:20);
plot(sigma_pre,symbols{i})

end

f11 = figure(1);
legend('h=15','h=25','h=35','Location','Best')
xlabel('unpreserved bamboo samples')
ylabel('$\bar{k} \left[ W/mK \right] $','interpreter','latex')
ylim([0.1 0.6])

f12 = figure(2);
legend('h=15','h=25','h=35','Location','Best')
xlabel('unpreserved bamboo samples')
ylabel('$\bar{\rho c_{p}} \times 10^{6} \left[J/(m^{3}K)\right]$','interpreter','latex')
ylim([2 10])

f21 = figure(3);
legend('h=15','h=25','h=35','Location','Best')
xlabel('preserved bamboo samples')
ylabel('$\bar{k} \left[ W/mK \right] $','interpreter','latex')
ylim([0.1 0.6])

f22 = figure(4);
legend('h=15','h=25','h=35','Location','Best')
xlabel('preserved bamboo samples')
ylabel('$\bar{\rho c_{p}} \times 10^{6} \left[J/(m^{3}K)\right]$','interpreter','latex')
ylim([2 10])

f8a = figure(5);
legend('h=15','h=25','h=35','Location','Best')
xlabel('unpreserved bamboo samples')
ylabel('$\bar{\alpha} \times 10^6  \left[ m^2/s \right] $','interpreter','latex')

f8b = figure(6);
legend('h=15','h=25','h=35','Location','Best')
xlabel('preserved bamboo samples')
ylabel('$\bar{\alpha} \times 10^6 \left[ m^2/s \right] $','interpreter','latex')


% epsPrinter('Fig7a',f11)
% epsPrinter('Fig7b',f12)
% epsPrinter('Fig7c',f21)
% epsPrinter('Fig7d',f22)
% epsPrinter('Fig8a',f8a)
% epsPrinter('Fig8b',f8b)

