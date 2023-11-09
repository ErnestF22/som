function test_problem_test_hess_antidiag
problem=test_problem();
curve=test_problem_curve(problem);

c=curve.c;
dc=curve.dc;

f=@(t) problem.cost(c(t));
rgradf=@(t) problem.rgrad(c(t));


% A
ahess = @(t) problem.ahess_f(c(t),dc(t));
ahess(0);


%B
bhess = @(t) problem.bhess_f(c(t),dc(t));
bhess(0)



end %file function





