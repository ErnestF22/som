
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear;
close all;
clc;

resetRands(2);

d = 3;
nrs = d+1;
N = 5;

%graph random init
e = 7;
G = graph(true(N), 'omitselfloops'); % Alternative without self-loops
p = randperm(numedges(G), e);
G = graph(G.Edges(p, :));
edges = table2array(G.Edges);
num_edges = e;

%testdata random init
% testdata = testNetwork_som(3); %4 is the default option
% edges = (testdata.E);
% num_edges = testdata.NEdges;

R_globalframe = make_rand_stiefel_3d_array(nrs, d, N);
T_globalframe = 10 * rand(nrs, N);
% Tijs_vec = 10 * rand(d, num_edges);
Tijs_vec = zeros(d, num_edges);

R_transp = matStack(multitransp(R_globalframe));

P = make_p(T_globalframe, Tijs_vec, edges);
frct = compute_step1_fixed_cost_term(T_globalframe, Tijs_vec, edges);

cost_rot = trace(R_transp*P) + frct;
disp("cost_rot");
disp(cost_rot);

% R_stacked = matStack(R_globalframe);
% [LT, PT] = make_LT_PT_stiefel(T_globalframe, Tijs_vec, edges);
% fct_old = compute_fixed_cost_term(Tijs_vec, d);
% cost_rot_old = trace(R_stacked' *LT*R_stacked) + trace(R_stacked'*PT) + fct_old;
% disp("cost_rot_old");
% disp(cost_rot_old);



% cost_rot_noloops = trace(R_transp*P_noloops) + frct_noloops;
% disp("cost_rot_noloops");
% disp(cost_rot_noloops);

[A_rsom,b_rsom] = make_Aconst_b(R_globalframe, Tijs_vec, edges);
cost_transl = norm(vec(A_rsom .* T_globalframe) + b_rsom)^2;

[A,b] = make_A_b_stiefel(R_globalframe, T_globalframe, Tijs_vec, edges);
cost_transl = norm(vec(A_rsom .* T_globalframe) + b_rsom)^2;


cost_1 = 0.0;
for e = 1:num_edges
    ii = edges(e,1);
    jj = edges(e,2); 
    R_i = R_globalframe(:,:,ii);
    T_j = T_globalframe(:, jj);
    T_i = T_globalframe(:, ii);
    cost_e = norm(R_i * Tijs_vec(:,e) - T_j + T_i);
    cost_1 = cost_1 + cost_e^2; %squared!
end


disp("[cost_1, cost_rot, cost_transl]")
disp([cost_1, cost_rot, cost_transl])


