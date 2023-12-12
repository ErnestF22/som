function [D] = SO3xR3xSO3_metric(Z,X,Y)
% Compute the natural metric on SO3xR3xSO3
%%%%%Assume all matrices are numerics!%%%%%
% INPUTS:
%   Z := Point of evaluation (R1,p,R2)
%   X,Y := Vector fields
% OUTPUTS:
%   D := result of <X,Y> on SO3xR3xSO3

% Extract components
Z_SO3_1 = extractComp(Z,1,3,1,3);
X_SO3_1 = extractComp(X,1,3,1,3);
Y_SO3_1 = extractComp(Y,1,3,1,3);
Z_R3 = extractComp(Z,4,6,1,3);
X_R3 = extractComp(X,4,6,1,3);
Y_R3 = extractComp(Y,4,6,1,3);
Z_SO3_2 = extractComp(Z,7,9,1,3);
X_SO3_2 = extractComp(X,7,9,1,3);
Y_SO3_2 = extractComp(Y,7,9,1,3);

% Compute metric on SO3 for R1
D_SO3_1 = rot_metric(Z_SO3_1,X_SO3_1,Y_SO3_1);
% Compute metric on R3
D_R3 = rot_metric(Z_R3,X_R3,Y_R3);
% Compute metric on SO3 for R2
D_SO3_2 = rot_metric(Z_SO3_2,X_SO3_2,Y_SO3_2);

% Sum metric
D = D_SO3_1 + D_R3 + D_SO3_2;
end

