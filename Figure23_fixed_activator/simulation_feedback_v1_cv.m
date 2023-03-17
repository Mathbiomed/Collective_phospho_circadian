clear; close all;
disp('Last Editted on Mar 17 2023')

delay_mean_list=[4.9*60]; % mean delay of mean-sized cell
delay_cv_list=[0.25,0.5,0.75,1];
phos_deg_reg_list=[1];
repeat_time=10;

X_list_switch=zeros(300000,5,repeat_time,  length(delay_cv_list));
X_list_ultra=zeros(300000,5,repeat_time, length(delay_cv_list));
X_list_linear=zeros(300000,5,repeat_time, length(delay_cv_list));

% lambda_p=;
A=300;

tic
temp_X_switch=zeros(300000,5,repeat_time,  1);
temp_X_ultra=zeros(300000,5,repeat_time, 1);
temp_X_linear=zeros(300000,5,repeat_time, 1);

for delay_cv_i=1:length(delay_cv_list)


    lambda_p=3;
    lambda_d=0.0015; % 385 min
    lambda_n=0.012;
    lambda_p_list=[4.5];
    lambda_n_list=[0.012];
    delay_mean=[4.9*60];
    delay_cv=delay_cv_list(delay_cv_i);
    phos_deg_ratio=1;

    temp_X_switch(:,:,:,1)...
        = Gillespie_switch_feedback_v4(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, A, repeat_time);
    temp_X_ultra(:,:,:,1)...
        = Gillespie_ultra_feedback_v4(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, A, repeat_time);
    temp_X_linear(:,:,:,1)...
        = Gillespie_linear_feedback_v4(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, A, repeat_time);
    X_list_switch(:,:,:,delay_cv_i)=temp_X_switch;
    X_list_ultra(:,:,:,delay_cv_i)=temp_X_ultra;
    X_list_linear(:,:,:,delay_cv_i)=temp_X_linear;

end


toc
save('X_list_oscillation_switch_cv','X_list_switch','-v7.3')
save('X_list_oscillation_ultra_cv','X_list_ultra','-v7.3')
save('X_list_oscillation_linear_cv','X_list_linear','-v7.3')
