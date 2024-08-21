function check_recovery_error

load('poc2degree_data/recovery_check.mat','R');
load('poc2degree_data/recovery_check.mat','T');
R_manopt_out = R;
T_manopt_out = T;
X_manopt_out.R = R_manopt_out;
X_manopt_out.T = T_manopt_out;
clear R T;
load('poc2degree_data/recovery_check.mat','params');
load('poc2degree_data/recovery_check.mat','edges');
load('poc2degree_data/recovery_check.mat','d');
load('poc2degree_data/recovery_check.mat','N');
load('poc2degree_data/recovery_check.mat','staircase_step_idx');
load('poc2degree_data/recovery_check.mat','Tijs');
load('poc2degree_data/recovery_check.mat','X_gt');
load('poc2degree_data/recovery_check.mat','problem_struct_next');


% if staircase_step_idx > d+1

low_deg = 2; %TODO: not necessarily in more complex graph cases
nodes_high_deg = params.node_degrees > low_deg;

[T_edges, T1_offset] = make_T_edges(T_manopt_out, edges);

RT_stacked_high_deg = [matStackH(R_manopt_out(:,:,nodes_high_deg)), T_edges];
Qx = POCRotateToMinimizeLastEntries(RT_stacked_high_deg);
% RT_stacked_high_deg_poc = Qx * RT_stacked_high_deg;

R_tilde = multiprod(repmat(Qx, 1, 1, sum(nodes_high_deg)), R_manopt_out(:,:,nodes_high_deg));

R_recovered = zeros(d,d,N);
R_recovered(:,:,nodes_high_deg) = R_tilde(1:d,:,:);


% nodes_low_deg = ~nodes_high_deg;
for node_id = 1:length(params.node_degrees)
    node_deg = params.node_degrees(node_id);
    if node_deg == low_deg
        fprintf("Running recoverRitilde() on node %g\n", node_id);
        R_i_tilde2 = R_manopt_out(:,:,node_id);
        
        check_Rb_params.node_degrees = params.node_degrees;
        check_Rb_params.nrs = staircase_step_idx - 1;
        check_Rb_params.d = d;
        check_Rb_params.R_gt = params.R_gt;
        check_Rb_params.T_gt = params.T_gt;

        [Tij1j2, Tij1j2_tilde] = make_Tij1j2s(node_id, R_manopt_out, T_manopt_out, Tijs,edges,check_Rb_params);


        cost_gt = rsom_cost_base(X_gt, problem_struct_next); 
        disp("cost_gt")
        disp(cost_gt)

        cost_manopt_output = rsom_cost_base(X_manopt_out, problem_struct_next); 
        disp("cost_manopt_output")
        disp(cost_manopt_output)

        [RitildeEst1,RitildeEst2,Qx_i,Rb_i]=recoverRitilde(R_i_tilde2,Tij1j2_tilde);
        disp('')
        % TODO: how to decide between RitildeEst1,RitildeEst2??
        R_recovered(:,:,node_id) = RitildeEst1(1:d,:);
        T_diffs_shifted = Qx * T_edges; %this has last row to 0
        disp("Checking make_T_edges <-> edge_diffs_2_T");
        
        T_recovered = edge_diffs_2_T(T_diffs_shifted(1:d,:), edges, N);
    end
end


%checking that cost has not changed during "recovery"
X_recovered.T = T_recovered;
X_recovered.R = R_recovered;
cost_out = rsom_cost_base(X_recovered, problem_struct_next); 
disp("cost_out")
disp(cost_out)

transf_out = RT2G(R_recovered, T_recovered); %??

end %file function

%%
function Qx=align2d(v)
Q=fliplr(orthComplement(v));
Qx=flipud(orthCompleteBasis(Q)');
end

function RbEst=procrustesRb(c,q)
[U,~,V]=svd(c*q');
RbEst=U*diag([1 det(U*V')])*V';
end

function [RitildeEst1,RitildeEst2,Qx,RbEst]=recoverRitilde(Ritilde2,Tijtilde)
Qx=align2d(Tijtilde);
QxRitilde2Bot=Qx(3:4,:)*Ritilde2;
[U,~,~]=svd(QxRitilde2Bot,'econ');
c=U(:,2);

QLastRight=Qx(3:4,4)';

RbEst=procrustesRb(c,QLastRight');
RitildeEst1=Qx*blkdiag(eye(2),-RbEst')*Qx'*Ritilde2;
RitildeEst2=Qx*blkdiag(eye(2),RbEst')*Qx'*Ritilde2;
end
