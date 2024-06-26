clc;
clear;
close all;

load('Qbnn_data/Qbnn_R.mat', 'R')
load('Qbnn_data/Qbnn_T.mat', 'T')
load('Qbnn_data/Qbnn_edges.mat', 'edges')
% load('Qbnn_data/Qbnn_Q.mat', 'Q')
% load('Qbnn_data/Qbnn_x_out.mat', 'x_out')
% load('Qbnn_data/Qbnn_T_diffs.mat', 'T_diffs')
load('Qbnn_data/Qbnn.mat') %whole workspace
Tijs = problem_data.Tijs; %loaded from ws

d = 3;
N = 5;
nrs = 4;
p = nrs;

%% standard recovery method
T_edges = make_T_edges(T, edges);
% x_rs = [matStackH(R), T_edges];
R_deg3 = matStackH(R(:,:,2:4));
x_R = matStackH(R_deg3);

Qa = POCRotateToMinimizeLastEntries(x_R);
disp('x_rs=')
disp(x_rs)
disp('R=')
disp(R)
disp('x=Q*x_R=')
disp(Qa*x_R)
x = Qa*x_R;
if max(abs(x(d+1:end, :)), [], "all") > 1e-5
    disp("max(abs(x(d+1:end, :)), [], ""all"") > 1e-5!!! " + ...
        "-> x on SE(d)^N recovery failed")
    rs_recovery_success = boolean(0);
end 
% x_out = matUnstackH(x(1:d, 1:N*d));
% T_diffs = x_rs(1:d, N*d+1:end);
% [T_out, booleans_T] = edge_diffs_2_T(T_diffs, edges, N);
% if min(booleans_T) < 1
%     disp("min(booleans_T) < 1!!! -> T recovery failed")
%     rs_recovery_success = boolean(0);
% end 

transf_out = RT2G(x_out, T_out); %??


%% find Qb

%set up data

%trying with i=1
%its edges are j1 = 2, j2 = 3
edge_deg = 2;
i = 1;
j1 = 2;
j2 = 3;
R_i = R(:,:,1);
idx_i_j1 = find(ismember(edges, [i, j1], "rows"));
idx_i_j2 = find(ismember(edges, [i, j2], "rows"));
T_i_j1_j2 = [Tijs(:,idx_i_j1), Tijs(:,idx_i_j2)];
T_i_j1_j2_tilde = - [T(:,i) - T(:,j1), T(:,i) - T(:,j2)]; % !! -

disp("max(abs(R_i * T_i_j1_j2 - T_i_j1_j2_tilde),[], ""all"")")
disp(max(abs(R_i * T_i_j1_j2 - T_i_j1_j2_tilde),[], "all"))
disp("max(abs(Qa * R_i * T_i_j1_j2 - Qa* T_i_j1_j2_tilde),[], ""all"")")
disp(max(abs(Qa * R_i * T_i_j1_j2 - Qa* T_i_j1_j2_tilde),[], "all"))

% Create the problem structure.
manifold = stiefelfactory(p-2,p-2);
problem_Qbnn.M = manifold;
 
% Define the problem cost function and its Euclidean gradient.
problem_Qbnn.cost  = @(x) mycost_Qbnn(Qa, x, R_i, T_i_j1_j2, T_i_j1_j2_tilde);
problem_Qbnn = manoptAD(problem_Qbnn);
 
% Numerically check gradient consistency (optional).
checkgradient(problem_Qbnn);
 
% Solve.
options.maxiter = 100;
[Rb, xcost, info, options] = trustregions(problem_Qbnn,[],options);

Qb = blkdiag(eye(edge_deg), Rb);
disp("Qb")
disp(Qb)

disp("max(abs(Qb * Qa * R_i * T_i_j1_j2 - Qa* T_i_j1_j2_tilde),[], ""all"")")
disp(max(abs(Qb * Qa * R_i * T_i_j1_j2 - Qa* T_i_j1_j2_tilde),[], "all"))

% Qa' * Qb * Qa * R_i * T_i_j1_j2 - T_i_j1_j2_tilde == 0
Qa_i = POCRotateToMinimizeLastEntries(x_R);
disp("max(abs(Qa' * Qb * Qa * R_i * T_i_j1_j2 - T_i_j1_j2_tilde), [], ""all"")")
disp(max(abs(Qa' * Qb * Qa * R_i * T_i_j1_j2 - T_i_j1_j2_tilde), [], "all"))

%% check on all Rs

step1 = x; % x = Qa*x_R
disp("max(abs(step1(end, :)), [], ""all"")")
disp(max(abs(step1(end, :)), [], "all"))

step2 = Qb * step1;
disp("max(abs(step2(end, :)), [], ""all"")")
disp(max(abs(step2(end, :)), [], "all"))

disp("max(abs(step1-step2), [], ""all"")")
disp(max(abs(step1-step2), [], "all"))

% step3 = Qa' * Qb * step2;
% disp("max(abs(step3(end, :)), [], ""all"")")
% disp(max(abs(step3(end, :)), [], "all"))

x_R = matStackH(R);
disp("Qa * x_R")
disp(Qa * x_R)

disp("Qb * Qa * x_R")
disp(Qb * Qa * x_R)

disp("Qa' * Qb * Qa * x_R")
disp(Qa' * Qb * Qa * x_R)

%% actual Q1
disp("actual Qs")
Q1 = POCRotateToMinimizeLastEntries(R(:,:,1));
disp("[Q1, Q1*R(:,:,1)]")
disp([Q1, Q1*R(:,:,1)])

Q5 = POCRotateToMinimizeLastEntries(R(:,:,5));
disp("[Q5, Q5*R(:,:,5)]")
disp([Q5, Q5*R(:,:,5)])

%% A+B
i1 = 1;
i2 = 5;
deg_i = 2;

nodes_low_deg = [i1, i2];

tuple.qc = stiefelfactory(p,p);
tuple.qb = stiefelfactory(p-deg_i,p-deg_i);
problem_qcqb.M = productmanifold(tuple);

for jj = nodes_low_deg
    Ri = R(:,:,jj);
    
    % Define the problem cost function and its Euclidean gradient.
    problem_qcqb.cost = @(x) mycost_qcqb(x, Qa, Ri, T_i_j1_j2, T_i_j1_j2_tilde);
    problem_qcqb = manoptAD(problem_qcqb);
     
    % Numerically check gradient consistency (optional).
    % checkgradient(problem_qcqb);
     
    % Solve.
%     initguess_j.qc = make_rand_stiefel_3d_array(p,p,1);
%     initguess_j.qb = make_rand_stiefel_3d_array(p-deg_i,p-deg_i,1);
%     [qcqb_out_i, xcost, info, options] = ...
%         trustregions(problem_qcqb,initguess_j,options);
    [qcqb_out_i, xcost, info, options] = ...
        trustregions(problem_qcqb,[],options);

    Qcd_i = eye(p); %??
    disp("qcqb_out_i.qc' * Qcd_i * Ri")
    disp(qcqb_out_i.qc' * Qcd_i * Ri)
end


%% costs

% function c_out = mycost_Qbnn(Qa, Rb, Ri, Ti, Ti_tilde)
%     p = size(Qa, 1);
%     Qb = eye(p);
%     Qb(p-1:end, p-1:end) = Rb;
%     c = Qa' * Qb * Qa * Ri;
%     c_out = norm(c(end,:));
% end

function c_out = mycost_Qbnn(Qa, Rb, Ri, Ti, Ti_tilde)
    p = size(Qa, 1);
    Qb = eye(p);
    Qb(p-1:end, p-1:end) = Rb;
    c = Qa' * Qb * Qa * Ri * Ti - Ti_tilde;
    c_out = norm(c(:));
end

function c_out = mycost_qcqb(x, Qa, Ri, Ti, Ti_tilde)
    Qcdd_i = x.qc;
    Qb_i = x.qb;
    p = size(Ri,1);
    d = size(Ri,2);
    % A
    P = [zeros(p-d,d), eye(p-d)];
    Qcd_i = eye(p);
    A = P * Qcdd_i' * Qcd_i * Ri;
    % B
    Qb = eye(p);
    Qb(p-1:end, p-1:end) = Qb_i;
    B = Qcdd_i' - Qa' * Qb * Qa;
    % sum of norms
    c_out = norm(A(:)) + norm(B(:)); % ^2?
end
