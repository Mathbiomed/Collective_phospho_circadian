disp('Simulation for figure 4B')


load('Bmal1_protein')
lambda_p_list=[12.5];
lambda_n_list=[0.012];
delay_mean_list=[294];
delay_cv_list=[0.5];
% particle_num_list=[500,750,1000,1250,1500];
phos_deg_reg_list=[1];
repeat_time=10;

X_list_switch=zeros(300000,5,repeat_time);
X_list_ultra=zeros(300000,5,repeat_time);
X_list_linear=zeros(300000,5,repeat_time);

lambda_d=0.0045;

tic
for lambda_n_i=1

    for delay_mean_i=1:length(delay_mean_list)
        for delay_cv_i=1:length(delay_cv_list)
            for lambda_p_i=1:length(lambda_p_list)
                mean_delay=delay_mean_list(delay_mean_i);
                activator=Bmal1_protein_processing(4,Bmal1_protein);
                %%%%%%%%%%%%%%%%%%%%%%%
                phos_deg_reg_i=1;
                phos_deg_ratio=phos_deg_reg_list(phos_deg_reg_i);
                %%%%%%%%%%%%%%%%%%%%%%%

                lambda_n=lambda_n_list(lambda_n_i);
                delay_mean=delay_mean_list(delay_mean_i);
                delay_cv=delay_cv_list(delay_cv_i);
                lambda_p=lambda_p_list(lambda_p_i);

                X_list_switch(:,:,:)...
                    = Gillespie_switch_actinorm_v2(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, activator, repeat_time);
                X_list_ultra(:,:,:)...
                    = Gillespie_ultra_actinorm_v2(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, activator, repeat_time);
                X_list_linear(:,:,:)...
                    = Gillespie_linear_actinorm_v2(lambda_p, lambda_n, lambda_d, phos_deg_ratio, delay_mean, delay_cv, activator, repeat_time);

            end
        end
    end
    toc
    save(strcat('X_list_activator_switch'),'X_list_switch','-v7.3')
    save(strcat('X_list_activator_ultra'),'X_list_ultra','-v7.3')
    save(strcat('X_list_activator_linear'),'X_list_linear','-v7.3')

end