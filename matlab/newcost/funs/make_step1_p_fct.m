function [P, fct] = make_step1_p_fct(T_gf, T_ijs, edges)
%MAKE_STEP1_P_FCT Run make_p and compute_step1_fixed_cost_term
% and return the results.

P = make_p_noloops(T_gf, T_ijs, edges);
fct = compute_step1_fct_noloops(T_gf, T_ijs, edges);



end %file function