% rotRefOptAll_Setup_simulations.m
% Last Edited: Oct. 28, 2020 by Bee Vang
% Script to run simulations for optimal controller and static gain
% controller

% clean up
close all; clear all; clc;
TEST_CASE = 1;
PLOT_TYPE = 1;

% Load (Pre-)simulation data. This includes the initial conditions,
% contraction metric, best static gains
load('rotRefOpt_PreSimulationData_20201028.mat');

% Generate the function handle for the bounds
% bounds_func_simple = rotRefOpt_allBounds_Matrix_simple();
% bounds_func_der_simple = rotRefOpt_allBounds_Matrix_der_simple();

% Run simulation
switch TEST_CASE
    case 1
        % Case 1: The optimal gain controller with dynamic gains, metric,
        % and convergence rate
        [x,t,control]=rotRefOptAll_simulation(mag_R,mag_RRef,mag_W,M_nn,...
            'init_r',R0,...
            'init_rref',RRef0,...
            'gains',[kd,kv,kp],...
            'endtime',8,...
            'init_vel',-w0);
        save('sim_VaryingGainController.mat');
    case 2
        % Case 2: Static gains and metric
        [x,t,control]=rotRefOptAll_simulation(mag_R,mag_RRef,mag_W,M_nn,...
            'init_r',R0,'init_rref',RRef0,...
            'gains',[kd,kv,kp],'endtime',8,'init_vel',-w0,...
            'skip_optimization_parameters');
        save('sim_StaticGainController.mat');
    case 3
        % Gain Schedule Controller
        % Load the gains from a file as a structure
        load('GainScheduled_Gains.mat');
        [x,t,control]=rotRefOptAll_simulation(mag_R,mag_RRef,mag_W,M_nn,...
            'init_r',R0,'init_rref',RRef0,...
            'gains',[kd,kv,kp],'endtime',8,'init_vel',-w0,...
            'gainschedulecontroller',GainScheduledParams);
        % Go back and correct the gains/reference trajectory since it was
        % not possible during ode45 simulation
        for i = 1:size(x,2)
            x(:,i) = rotRefOpt_GainSchedule_Checker(x(:,i),GainScheduledParams);
        end
        save('sim_GainScheduleController.mat');
end

switch PLOT_TYPE
    case 1
        % plot for dynamic controller
        rotRefOptAll_plotSim(x,t,'plot_contraction_mat',...
            'plot_control',control, ...
            'enable_title','All Dyn',...
            'plot_gains',...
            'plot_convergence_rate',...
            'plot_metric');
    case 2
        % plot for static controller
        rotRefOptAll_plotSim(x,t,'plot_contraction_mat',...
            'plot_control',control, ...
            'enable_title','All Static',...
            'plot_gains',...
            'plot_convergence_rate',...
            'plot_metric',...
            'static_parameters_solve_convergence_rate');
end

%% Compare multiple test on same plots
rotRefOptAll_plotSim('sim_StaticGainController.mat','datalabel','SC','plot_contraction_mat',...
'plot_control', ...
'enable_title','All Dyn',...
'plot_gains',...
'plot_convergence_rate',...
'plot_metric',...
'addfile','sim_VaryingGainController.mat','VGC',...
'addfile','sim_GainScheduleController.mat','GSC',...
'save_figure','Figures/Fig');