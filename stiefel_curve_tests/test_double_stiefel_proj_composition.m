function test_double_stiefel_proj_composition
%Test whether Proj_x[u] \circ Proj_x[u] = Proj_x[u]
%the property below Prop. 5.32 page 111 of Boumal Intro book
num_rows_stiefel = 4;
d = 3;
n = 5;
x = make_rand_stiefel_mat(num_rows_stiefel, d, n);
u = make_rand_stiefel_mat(num_rows_stiefel, d, n);

one_proj = stp_manopt(x, u);
two_proj = stp_manopt(x, one_proj);

disp(max(abs(one_proj - two_proj), [], "all"));


end %file function
