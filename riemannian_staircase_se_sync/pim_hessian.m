function v_max = pim_hessian(x, problem, thresh)
%PIM_HESSIAN (PIM is an acronym for Power Iteration Method) 
% Iterative method that processes function f at point x in a similar fashion
% to applying the power augmentation method with the linear map f in place
% of the matrix of which the maximum eigenvalue would be computed

if ~exist('thresh','var')
  thresh=1e-5;
end

iterative_change = 1e+6;

v = stiefel_randTangentNormVector(x); %??



iteration_num = 0;
while (iterative_change > thresh) && (iteration_num < 1000)
    hes =  som_rhess_rot_stiefel(x, v, problem);
    iteration_num = iteration_num + 1;
    v_prev = v;
    stm_3d(1,1,:) = stiefel_metric([], v, v, 'euclidean');
    v = multidiv(hes, stm_3d);
    % H*v ???
    v = - v;
    iterative_change = min( max(stiefel_metric([], v_prev, v, 'euclidean')), ...
        max(stiefel_metric([], v, v_prev, 'euclidean')) ) ;
end

v_max = v;

end

