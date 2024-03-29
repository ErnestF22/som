function P = make_p_noloops(T_gf, Tijs_vec, edges)
%MAKE_P_NOLOOPS Make matrix P used in step1 (rotation estimation) 
% cost formulation WITHOUT using any for loops

nrs = size(T_gf, 1);
d = size(Tijs_vec, 1);
N = size(T_gf, 2);

adj_mat = make_adj_mat_from_edges(edges, N);

M = num2cell(adj_mat); %mask

% P = zeros(nrs, d*N);

% num_edges = size(edges,1);

%A
T_gf_cells = num2cell(T_gf, 1);
A_1 = repmat(T_gf_cells, N, 1);
A_2 = repmat(T_gf_cells', 1, N);
A = cellfun(@minus, A_2, A_1,'Un',0);

%B
Tijs_mat = tijs_vec_2_tijs_mat(Tijs_vec, edges, N);
B = mat2cell(Tijs_mat, d*ones(1,N), ones(1,N));
B_transp = cellfun(@transp,B,'Un',0);

%C
C = cellfun(@times,A,B_transp,'Un',0);
% celldisp(C)

P_half = cellfun(@times,C,M,'Un',0); %apply mask

P_half_mat = cell2mat(P_half);

P_half_mat_1 = vec(P_half_mat);
P_half_mat_2 = reshape(P_half_mat_1, nrs*N*d, []);
P_half_mat_3 = sum(P_half_mat_2, 2);
P_half_mat_4 = reshape(P_half_mat_3, nrs*N,d);

P_half_mat_out_bad = P_half_mat_4';
P_half_mat_out_bad_notransp = mat2cell(P_half_mat_out_bad, d, nrs*ones(1,N));
P_half_mat_out = cell2mat(cellfun(@transpose,P_half_mat_out_bad_notransp,'Un',0)); %apply mask


P = 2 * P_half_mat_out;



end %file function


