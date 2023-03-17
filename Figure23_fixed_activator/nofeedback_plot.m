% Run "simulation_nofeedback.m" to obtain simulation data


clear; close all;

load('fpt_colors_v3.mat')
load('X_list_linear_no_feedback_cv.mat')
load('X_list_ultra_no_feedback_cv.mat')
load('X_list_switch_no_feedback_cv.mat')
%%
A=300;
figure
subplot(1,3,1)
hold on
for i=1:4
    temp_X=X_list_linear(:,:,:,1,1,i);
    plot(temp_X(:,1),max(1-temp_X(:,5)/A,0), 'Color',[linear_color,0.3+0.7/5*i],'LineWidth',2)
end
xlim([0,480])
xticks([])
yticks([0,1])
ylim([0,1])
box on
set(gca,'LineWidth',1,'FontSize',12)

subplot(1,3,2)
hold on
for i=1:4
    temp_X=X_list_ultra(:,:,:,1,1,i);
    plot(temp_X(:,1),max(1-temp_X(:,5)/A,0), 'Color',[ultra_color,0.3+0.7/5*i],'LineWidth',2)
end
xlim([0,480])
xticks([])
yticks([0,1])
ylim([0,1])
box on
set(gca,'LineWidth',1,'FontSize',12)

subplot(1,3,3)
hold on
for i=1:4
    temp_X=X_list_switch(:,:,:,1,1,i);
    plot(temp_X(:,1),max(1-temp_X(:,5)/A,0), 'Color',[switch_color,0.3+0.7/5*i],'LineWidth',2)
end
xlim([0,480])
xticks([])
yticks([0,1])
ylim([0,1])
box on
set(gca,'LineWidth',1,'FontSize',12)


set(gcf,'Position',[0,0,600,200])

