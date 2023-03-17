load('fpt_colors_v3')
load('X_list_activator_linear.mat')
load('X_list_actinvator_ultra.mat')
load('X_list_activator_switch.mat')
load('Bmal1_protein')
% close all

% activator=Bmal1_protein_processing_original(24/5,250,4,Bmal1_protein);

figure
subplot(3,1,1) 


plot(X_list_linear(:,1),X_list_linear(:,5),'Color',linear_color,'LineWidth',1)
xlim([51480,55440])
xticks([51480:1440:55440,55440])
xticklabels(["0","24","48","68"])
ylim([0,500])
yticks([0,500])
set(gca,'TickDir','out')

subplot(3,1,2)
plot(X_list_ultra(:,1),X_list_ultra(:,5),'Color',ultra_color,'LineWidth',1)
xlim([39600,43560])
xticks([39600:1440:43560,43560])
xticklabels(["0","24","48","68"])
yticks([0,500])
ylim([0,500])

set(gca,'TickDir','out')


subplot(3,1,3)

plot(X_list_switch(:,1),X_list_switch(:,5),'Color',switch_color,'LineWidth',1)

xlim([39600,43560])
xticks([39600:1440:43560,43560])
xticklabels(["0","24","48","68"])
set(gca,'TickDir','out')
yticks([0,500])
ylim([0,500])