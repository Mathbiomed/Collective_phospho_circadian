% Run "simulation_feedback.m" first to obtain simulation data


load('X_list_oscillation_linear_cv.mat')
load('X_list_oscillation_ultra_cv.mat')
load('X_list_oscillation_switch_cv.mat')

load('fpt_colors_v3')

subplot(3,2,1)
temp_X=X_list_linear(:,:,1,1);
plot(temp_X(:,1),temp_X(:,5),'Color',linear_color,'LineWidth',2)
xlim([1.6e4,1.6e4+4320])
ylim([0,500])
xticks([])
yticks([0,500])
set(gca,'FontSize',12,'LineWidth',1.2)

subplot(3,2,2)
temp_X=X_list_linear(:,:,1,3);
plot(temp_X(:,1),temp_X(:,5),'Color',linear_color,'LineWidth',2)
xlim([1.6e4,1.6e4+4320])
ylim([0,500])
xticks([])
yticks([0,500])
set(gca,'FontSize',12,'LineWidth',1.2)


subplot(3,2,3) 
temp_X=X_list_ultra(:,:,1,1);
plot(temp_X(:,1),temp_X(:,5),'Color',ultra_color,'LineWidth',2)
xlim([1.6e4,1.6e4+4320])
ylim([0,700])
xticks([])
yticks([0,700])
set(gca,'FontSize',12,'LineWidth',1.2)


subplot(3,2,4)
temp_X=X_list_ultra(:,:,1,3);
plot(temp_X(:,1),temp_X(:,5),'Color',ultra_color,'LineWidth',2)
xlim([1.6e4,1.6e4+4320])
ylim([0,700])
xticks([])
yticks([0,700])
set(gca,'FontSize',12,'LineWidth',1.2)


subplot(3,2,5)
temp_X=X_list_switch(:,:,1,1);
plot(temp_X(:,1),temp_X(:,5),'Color',switch_color,'LineWidth',2)
xlim([1.6e4,1.6e4+4320])
ylim([0,700])
xticks([])
yticks([0,700])
set(gca,'FontSize',12,'LineWidth',1.2)


subplot(3,2,6)
temp_X=X_list_switch(:,:,1,3);
plot(temp_X(:,1),temp_X(:,5),'Color',switch_color,'LineWidth',2)
xlim([1.6e4,1.6e4+4320])
ylim([0,700])
xticks([])
yticks([0,700])
set(gca,'FontSize',12,'LineWidth',1.2)

set(gcf,'Position',[0,0,700,600])