# Collective_phospho_circadian


This is a MATLAB code for the paper "Spatially coordinated collective phosphorylation filters spatiotemporal noises for precise circadian timekeeping
" by Chae et al. (2023) published in iScience. The code simulates the system describing the transcriptional-translational feedback loop (TTFL) of PER protein by using delayed Gillespie algorithm. 

## Code description
### TTFL simulation with fixed activator
1. Simulation_feedback.m
> Code for simulating TTFL model. This code performs simulation describing TTFL and generates oscillatory time series. Time series data are saved after simulation. 
> Simulation is peformed in different values of CV_\tau values.
2. Simulation_nofeedback.m
> Code for simulating part of TTFL model. This code performs simulation describing the process from the cytoplasmic trafficking to nuclear entry of proteins.
> Simulation is performed in different values of CV_\tau values.
3. Gillespie_switch_feedback.m
> MATLAB function for Gillespie simulation of TTFL with bistble phosphoswitch when the production rate, degradation rate, threshold, nuclear entry rate, the amount of activators, mean and the 
> standard deviation of delay are given. 
> Output of function is the simulated time series.
> Gillespie_linear_feedback.m/Gillespie_ultra_feedback.m are for Gillespie simulation of TTFL with linear and ultrasensitive phosphorylation, respectively.
4. Gillespie_switch_nofeedback.m
> MATLAB function for Gillespie simulation for part of TTFL when the degradation rate, threshold, nuclear entry rate, the amount of activators, mean and the 
> standard deviation of delay are given. 
> Output of function is the simulated time series.
> Gillespie_linear_feedback.m/Gillespie_ultra_feedback.m are for Gillespie simulation of TTFL with linear and ultrasensitive phosphorylation, respectively.
5. feedback_plot.m / nofeedback_plot.m
> Codes for plotting time series which are obtained from the simulation. You should run 1/2 before running this code.
### TTFL simulation with varying activator
1. Simulation_activator.
>Code for simulating TTFL model with varying activator. This is similar to "Simulation_feedback.m" but this uses experimentally measured BMAL1 data 
> as the amount of activator. Time series data are saved after simulation. 
2. Bmal1_protein_processing.m
> This code generates time series of activator by truncating the first few hours of BMAL1 data to avoid the initial shock for the experiment. 
3. Gillespie_switch_actinorm_v2.m
> MATLAB function for Gillespie simulation for part of TTFL when the degradation rate, threshold, nuclear entry rate, the amount of activators, mean and the 
> standard deviation of delay are given with the experimentally measured BMAL1 time series data. 
> Output of function is the simulated time series.
> Gillespie_linear_feedback.m/Gillespie_ultra_feedback.m are for Gillespie simulation of TTFL with linear and ultrasensitive phosphorylation, respectively.
4. activator_plot.m
> Codes for plotting time series which are obtained from the simulation. You should run 1 before running this code
