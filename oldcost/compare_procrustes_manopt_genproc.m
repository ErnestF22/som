% testNetwork_test(1); %argument omanoptf som.testNetwork_test should be the test number
% run ("../manopt/importmanopt.m");
% run ("../codemeta/pathdefrepository.m");

clc;
clear;
close all;

% 1a) PW TRANSLATION DATA INPUT: R, T are the gt, Tijs_nois are the input data
testdata = testNetwork_som(3); %4 would be the default

% som = ShapeOfMotion('testNetwork_params.csv'); %params reading is done directly in constructor
% %copy the list below from the properties list
N = testdata.NNodes;
d = 3;
d_aff = d+1;
global_camera_id = 1;
num_tests_per_sigma = 30;
transf_end_thresh = 1;
max_icp_iterations = 10;
num_edges_full = N*N;
num_edges = testdata.NEdges;
procrustes_mode = 'som';
riem_grad_mode = 'auto'; %'auto' or 'manual'
hessian_mode = 'auto'; 
initguess_is_available = boolean(1);
som_params = struct('N', N, 'd', d, 'd_aff', d_aff, ...
    'global_camera_id', global_camera_id, ...
    'num_tests_per_sigma', num_tests_per_sigma, 'transf_end_thresh', transf_end_thresh, ...
    'max_icp_iterations', max_icp_iterations, 'num_edges_full', num_edges_full, ...
    'num_edges', num_edges, 'procrustes_mode', procrustes_mode, ...
    'riem_grad_mode', riem_grad_mode, ...
    'hessian_mode', hessian_mode, ...
    'initguess_is_available', initguess_is_available);

% 0b) Noise PARAMS
%NOTE: sigmas, mus can be seen as couples for each test
sigmas = readmatrix("sigmas.txt"); %sigma = stdev, sigma.^2 = variance
mus = readmatrix("../data/mus.txt"); %OBS. generally, mus can be d-dimensional; here, we just assume them as scalar (i.e. a d-dimensional vector with all coordinates equal)

%If reading from file does not work and want to try a single noise_params
%struct, uncomment the following line
% noise_params = struct('sigma', sigmas(1), 'mu', mus(1)); 

manopt_sep_rot_errs = zeros(size(sigmas));
manopt_sep_transl_errs = zeros(size(sigmas));
manopt_sep_exec_times = zeros(size(sigmas));
manopt_gen_rot_errs = zeros(size(sigmas));
manopt_gen_transl_errs = zeros(size(sigmas));
manopt_gen_exec_times = zeros(size(sigmas));

%when multple sigmas and mus, and multiple tests per each pair
for ii = 1:size(sigmas,1)
    noise_params = struct('sigma', sigmas(ii), 'mu', mus(ii)); 
    sigma = noise_params.sigma;
    mu = noise_params.mu;

    manopt_sep_rot_errs_per_sigma = zeros(num_edges, num_tests_per_sigma);
    manopt_sep_transl_errs_per_sigma = zeros(num_edges, num_tests_per_sigma);
    manopt_sep_exec_times_per_sigma = zeros(1, num_tests_per_sigma); %column-wise just to keep a similar notation to the error vectors
    manopt_gen_rot_errs_per_sigma = zeros(num_edges, num_tests_per_sigma);
    manopt_gen_transl_errs_per_sigma = zeros(num_edges, num_tests_per_sigma);
    manopt_gen_exec_times_per_sigma = zeros(1, num_tests_per_sigma); %column-wise just to keep a similar notation to the error vectors

    for jj = 1:num_tests_per_sigma
        fprintf("ii %g jj %g\n", ii, jj);
        [manopt_sep_rot_err, manopt_sep_transl_err, ...
            manopt_gen_rot_err, manopt_gen_transl_err, ...
            manopt_sep_exec_time, manopt_gen_exec_time] = ...
            do_som_genproc(testdata, sigma, mu, som_params); % do_som();
        manopt_sep_rot_errs_per_sigma(:, jj) = manopt_sep_rot_err;
        manopt_sep_transl_errs_per_sigma(:, jj) = manopt_sep_transl_err;
        manopt_sep_exec_times_per_sigma(:, jj) = manopt_sep_exec_time;
        manopt_gen_rot_errs_per_sigma(:, jj) = manopt_gen_rot_err;
        manopt_gen_transl_errs_per_sigma(:, jj) = manopt_gen_transl_err;
        manopt_gen_exec_times_per_sigma(:, jj) = manopt_gen_exec_time;
    end
    
    manopt_sep_rot_errs(ii) = mean(manopt_sep_rot_errs_per_sigma,"all");
    manopt_sep_transl_errs(ii) = mean(manopt_sep_transl_errs_per_sigma,"all");
    manopt_sep_exec_times(ii) = mean(manopt_sep_exec_times_per_sigma);
    manopt_gen_rot_errs(ii) = mean(manopt_gen_rot_errs_per_sigma,"all");
    manopt_gen_transl_errs(ii) = mean(manopt_gen_transl_errs_per_sigma,"all");
    manopt_gen_exec_times(ii) = mean(manopt_gen_exec_times_per_sigma);

end    

% 4b)
disp("sigmas");
disp(sigmas);
disp("mus");
disp(mus);
disp("num_tests_per_sigma");
disp(num_tests_per_sigma);

% plot 
% on x sigmas
% on y the mean errors and the mean execution times (across all iterations) 

disp("manopt_sep_rot_errs");
disp(manopt_sep_rot_errs);

disp("manopt_sep_transl_errs");
disp(manopt_sep_transl_errs);

disp("manopt_gen_rot_errs");
disp(manopt_gen_rot_errs);

disp("manopt_gen_transl_errs");
disp(manopt_gen_transl_errs);

disp("manopt_sep_exec_times");
disp(manopt_sep_exec_times);

disp("manopt_gen_exec_times");
disp(manopt_gen_exec_times);

results = struct("manopt_sep_rot_errs", manopt_sep_rot_errs, ...
    "manopt_sep_transl_errs", manopt_sep_transl_errs, ...
    "manopt_sep_exec_times", manopt_sep_exec_times, ...
    "manopt_gen_rot_errs", manopt_gen_rot_errs, ...
    "manopt_gen_transl_errs", manopt_gen_transl_errs, ...
    "manopt_gen_exec_times", manopt_gen_exec_times);

%plot results
plot_results(sigmas, results, "manopt_sep_vs_gen");


