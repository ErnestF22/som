function h=rsom_rhess_rot_stiefel(x,u,problem)
% eh = rsom_ehess_rot_stiefel(x,u,problem);
% X = matStack(x);
% X_dot = matStack(u);
% U = matStack(rsom_egrad_rot_stiefel(x,problem));
% stief_proj_differential = X_dot * (X' * U + U' * X) + ...
%     X * (X_dot' * U + U' * X_dot);
% h = stp_manopt(x, matUnstack(stief_proj_differential, problem.sz(1))) + ...
%     stp_manopt(x, eh);
% h = stp_manopt(x, eh);
h = u;
end
