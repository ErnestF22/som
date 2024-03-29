clear;
close all;
clc;

resetRands(2);


d = 3;
nrs = d+1;
% N = 5;


testdata = testNetwork_som(3); %4 is the default option

N = testdata.NNodes;
edges = (testdata.E);
num_edges = testdata.NEdges;

% Tijs_vec = G2T(testdata.gijtruth);
% R_globalframe = G2R(testdata.gitruth);
% T_globalframe = G2T(testdata.gitruth);

% R_globalframe = randrot(d, N);
R_globalframe = make_rand_stiefel_3d_array(nrs, d, N);
T_globalframe = 10 * rand(nrs, N);
Tijs_vec = 10 * rand(d, num_edges);

%make P matrix with and without loops and check that the result is the same

P = make_p(T_globalframe, Tijs_vec, edges);
P_noloops = make_p_noloops(T_globalframe, Tijs_vec, edges);

disp("[P; P_noloops]")
disp([P; P_noloops])

disp("max(abs(P(:) - P_noloops(:)))");
disp(max(abs(P - P_noloops), [], "all"));

% fixed rot cost term
frct = compute_step1_fixed_cost_term(T_globalframe, Tijs_vec, edges);
frct_noloops = compute_step1_fct_noloops(T_globalframe, Tijs_vec, edges);

disp("[frct, frct_noloops]")
disp([frct, frct_noloops])

%Finally, check that costs are also the same
R_transp = matStack(multitransp(R_globalframe));

cost_2 = trace(R_transp*P) + frct;
disp("cost_2");
disp(cost_2);

cost_2_noloops = trace(R_transp*P_noloops) + frct_noloops;
disp("cost_2_noloops");
disp(cost_2_noloops);


