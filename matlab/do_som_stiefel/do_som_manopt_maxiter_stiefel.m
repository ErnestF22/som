function [rotation_error_manopt,translation_error_manopt, ...
    exectime_manopt] = ...
    do_som_manopt_maxiter_stiefel(testdata, sigma, mu, params)
%DO_SOM_MANOPT_MAXITER_STIEFEL Function that executes the Shape of Motion 
%algorithms through Manopt pipelines, with formulation on Stiefel manifold,
%returning rotation and translation errors, as well as the mean execution 
%time. This do_som() is for comparing the precision, accuracy and 
%exectime when increasing the maximum potential number of ICP iterations.


%parse used SoM params
N = params.N;

%edges
edges = (testdata.E);

%set gt
% transf_gt = testdata.gitruth;

%set data (no noise)
Tijs_vec = G2T(testdata.gijtruth);
T_globalframe = G2T(testdata.gitruth);

%add noise to data
Tijs_vec_nois = Tijs_vec + sigma.*randn(size(Tijs_vec));
T_globalframe_nois = T_globalframe + sigma.*randn(size(T_globalframe));

% 3) run Manopt and then manopt_ad

% 3a) execute with step 1 through MANOPT
%setup initguess
% R_initguess = G2R(rot_randn(testdata.gitruth, 0.0, N)); % this does not add any noise
R_truth=G2R(testdata.gitruth);
vR_noise=rot_randTangentNormVector(R_truth);
%R_initguess = G2R(rot_randn(testdata.gitruth, sigma_init, N));
R_initguess=rot_exp(R_truth,sigma*pi/5*vR_noise);
transl_initguess = T_globalframe + sigma.*randn(size(T_globalframe));
transf_initguess = RT2G(R_initguess, transl_initguess);
params.riem_grad_mode = 'manual';
manopt_start_time = tic();
transf_manopt = som_manopt_stiefel(T_globalframe_nois, Tijs_vec_nois, edges, params, matStack(transf_initguess));
% manopt_end_time = tic();
exectime_manopt = toc(manopt_start_time);


%4) compare output results
testdata.gi = matUnstack(transf_manopt, 4);
% [rotErr,translErr,scale_ratio,translErrNorm] = testNetworkComputeErrors(testdata)
[rotation_error_manopt,translation_error_manopt] = testNetworkComputeErrors(testdata);



end %function

