function [x_max, lambda_max] = pim_function(f, x_start, normalization_fun, thresh)
%PIM_FUNCTION (where PIM is an acronym for Power Iteration Method) 
% Iterative method that returns an eigenvector associated to the maximum 
% eigenvalue of matrix A
% x_start is the random vector from which PIM starts

if ~exist('thresh','var')
  thresh=1e-5;
end

iterative_change = 1e+6;
dim = size(x_start);
x = x_start;
iteration_num = 0;
iterative_change = 1e+6;
while (iterative_change > thresh) && (iteration_num < 1000)
    iteration_num = iteration_num + 1;
    x_prev = x;
    x = normalization_fun(x);
    x = - f(x);
%     iterative_change = min(normalization_fun(x_prev - x), ...
%         normalization_fun(x_prev + x));
end

x_max = x;
lambda_max = multiprod3(multitransp(x_max), f(x_max), x_max) / ...
    multiprod(multitransp(x_max), x_max);

end

