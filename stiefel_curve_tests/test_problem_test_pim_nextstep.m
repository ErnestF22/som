function test_problem_test_pim_nextstep

problem=test_problem();
curve=test_problem_curve(problem);


manif = stiefelfactory(problem.sz(1),problem.sz(2),problem.sz(3));
problem_manopt.M = manif;

problem_manopt.cost = @(x) som_cost_rot_stiefel(x, problem);
problem_manopt.egrad = @(x) som_egrad_rot_stiefel(x, problem);
problem_manopt.rgrad = @(x) som_rgrad_rot_stiefel(x, problem);
problem_manopt.ehess = @(x,u) som_ehess_rot_stiefel(x,u, problem);
problem_manopt.rhess = @(x,u) som_rhess_rot_stiefel(x,u, problem);


R_initguess = eye3d(problem.sz(1),problem.sz(2),problem.sz(3));
options.maxiter = 100;
[R, R_cost, R_info, R_options] = trustregions(problem_manopt, R_initguess, options);

problem_manopt.rgrad(R)
max(problem_manopt.rgrad(R),[], 'all');
[lambda_pim, v_pim] = pim_hessian(R, problem);

R_next = cat_zero_rows_3d_array(R);
v_pim_next = cat_zero_rows_3d_array(v_pim);
problem_next = problem;
problem_next.sz(1) = problem_next.sz(1) + 1;
L_next = from_L_to_L_next(problem.L, problem_next);
P_next = from_P_to_P_next(problem.P, problem_next);
problem_next.L = L_next;
problem_next.P = P_next;
[lambda_pim_next, v_pim_next] = pim_hessian(R_next, problem_next);

end %file function
