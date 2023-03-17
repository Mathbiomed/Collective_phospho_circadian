disp('Last Editted on Oct 8 2022')
disp('Simulation for Figure 1D-G(July 6), for finding initial reference parameter for the system')

lambda_n_list=[0.012];
% lambda_d_list=

delay_mean_list=4.9*60;
delay_cv_list=[0.25,0.5,0.75,1];
particle_num_list=[1000];

repeat_time=200;

X_list_switch=zeros(4000,5,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
X_list_ultra=zeros(4000,5,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
X_list_linear=zeros(4000,5,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));

Y_list_switch=zeros(4000,1,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
Y_list_ultra=zeros(4000,1,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
Y_list_linear=zeros(4000,1,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));

Z_list_switch=zeros(4000,1,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
Z_list_ultra=zeros(4000,1,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
Z_list_linear=zeros(4000,1,repeat_time, length(lambda_n_list), length(delay_mean_list), length(delay_cv_list), length(particle_num_list));

lambda_n_i=1;


lambda_d=0;
lambda_p=0;
A=0;
temp_X_switch=zeros(4000,5,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_X_ultra=zeros(4000,5,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_X_linear=zeros(4000,5,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_Y_switch=zeros(4000,1,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_Y_ultra=zeros(4000,1,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_Y_linear=zeros(4000,1,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_Z_switch=zeros(4000,1,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_Z_ultra=zeros(4000,1,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));
temp_Z_linear=zeros(4000,1,repeat_time, 1,length(delay_mean_list), length(delay_cv_list), length(particle_num_list));

for delay_mean_i=1
    for delay_cv_i=1:4
        for particle_num_i=1:length(particle_num_list)

            lambda_n=lambda_n_list(lambda_n_i);
            delay_mean=delay_mean_list(delay_mean_i);
            delay_cv=delay_cv_list(delay_cv_i); % Note that we are using the same index to mean
            particle_num=particle_num_list(particle_num_i);

            [temp_Y_switch(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i),temp_Z_switch(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i), temp_X_switch(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i)]...
                = Gillespie_switch_nofeedback_v6(lambda_p, lambda_n, lambda_d, delay_mean, delay_cv, particle_num, A, repeat_time);
            [temp_Y_ultra(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i),temp_Z_ultra(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i), temp_X_ultra(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i)]...
                = Gillespie_ultra_nofeedback_v6(lambda_p, lambda_n, lambda_d, delay_mean, delay_cv, particle_num, A, repeat_time);
            [temp_Y_linear(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i),temp_Z_linear(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i), temp_X_linear(:,:,:,1,delay_mean_i,delay_cv_i,particle_num_i)]...
                = Gillespie_linear_nofeedback_v6(lambda_p, lambda_n, lambda_d, delay_mean, delay_cv, particle_num, A, repeat_time);

        end
    end
end
X_list_switch(:,:,:,lambda_n_i,:,:,:)=temp_X_switch;
X_list_ultra(:,:,:,lambda_n_i,:,:,:)=temp_X_ultra;
X_list_linear(:,:,:,lambda_n_i,:,:,:)=temp_X_linear;
Y_list_switch(:,:,:,lambda_n_i,:,:,:)=temp_Y_switch;
Y_list_ultra(:,:,:,lambda_n_i,:,:,:)=temp_Y_ultra;
Y_list_linear(:,:,:,lambda_n_i,:,:,:)=temp_Y_linear;
Z_list_switch(:,:,:,lambda_n_i,:,:,:)=temp_Z_switch;
Z_list_ultra(:,:,:,lambda_n_i,:,:,:)=temp_Z_ultra;
Z_list_linear(:,:,:,lambda_n_i,:,:,:)=temp_Z_linear;


save('X_list_switch_no_feedback_cv_v1','X_list_switch','Y_list_switch','Z_list_switch','-v7.3')
save('X_list_ultra_no_feedback_cv_v1','X_list_ultra','Y_list_ultra','Z_list_ultra','-v7.3')
save('X_list_linear_no_feedback_cv_v1','X_list_linear','Y_list_linear','Z_list_linear','-v7.3')