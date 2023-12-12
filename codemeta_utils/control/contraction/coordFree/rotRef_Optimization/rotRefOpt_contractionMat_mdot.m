function [M_ALL] = rotRefOpt_contractionMat_mdot(varargin)
% Last Edited: Nov 12, 2020 by Bee Vang
% Compute the derivative of contraction metric on TSO(3)xSO(3) wrt the
% metric changing
% NOTE: Assumes m4==1 is fixed, otherwise cannot use in optimization problem
% INPUTS:
%   M_nonnatural := nonnatural metric gain matrix on TSO(3)xSO(3) in the
%       form of [m1 m2 m6;m2 m3 m5;m6 m5 m4]
%   dMnn_dt := derivative of M_nonnatural
% OUTPUTS:
%   M_ALL(R,w,RRef,gains,M_nn,M_nn_dot,beta) := Contraction matrix with arguements
%       R := current rotation [3x3]
%       w := current angular velocity [3x1]
%       RRef := reference rotation [3x3]
%       gains := vector of positive system gains [kd;kv;kref] [3x1]
%       M_nn := non-natural metric on TSO(3)xSO(3) [m1,m2,m6;m2,m3,m5;m6,m5,m4] [3x3]
%       M_nn_dot := der of M_nn wrt time
%       beta := positive scalar for convergence rate


%% Load Optional Parameters
flagOutputSymmetric = false;
%optional parameters
ivarargin=1;
len_varargin = length(varargin);
while ivarargin<=length(varargin)
    switch lower(varargin{ivarargin})
        case 'sym'
            flagOutputSymmetric = true;
        otherwise
            % ignore the entry and increase index until next entry is
            % a string
            while ivarargin+1 <= len_varargin && ~ischar(varargin{ivarargin+1})
                ivarargin=ivarargin+1;
            end 
    end
    ivarargin=ivarargin+1;
end

%% Compute the components of the M matrix on TSO(3) (THIS SHOULD BE DIFFERENT DUE TO log(R,RREF) term!!!)
M11 = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) (M_nn_dot(1,2) - M_nn_dot(2,3)*M_nn(1,3)/M_nn(3,3) - M_nn(2,3)*M_nn_dot(1,3)/M_nn(3,3))/4*hat3(w)^2 ...
    -M_nn_dot(1,2)*gains(1)*rot3_logDiffMat(RRef,R);

M21 = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) -(M_nn_dot(1,2) - M_nn_dot(2,3)*M_nn(1,3)/M_nn(3,3) - M_nn(2,3)*M_nn_dot(1,3)/M_nn(3,3))/4*hat3(w)...
    + (M_nn_dot(2,2) - 2*M_nn(2,3)*M_nn_dot(2,3)/M_nn(3,3))/8*hat3(w)^2 ...
    + (M_nn_dot(2,2) - 2*M_nn(2,3)*M_nn_dot(2,3)/M_nn(3,3))*gains(2)/4*hat3(w)...
    + (M_nn_dot(2,2) - 2*M_nn(2,3)*M_nn_dot(2,3)/M_nn(3,3))*gains(1)/4*rot_log(eye(3),RRef'*R)...
    -M_nn_dot(2,2)*gains(1)/2*rot3_logDiffMat(RRef,R)...
    +(M_nn_dot(1,1)-M_nn_dot(1,2)*gains(2))/2*eye(3);
M22 = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) (M_nn_dot(1,2)-M_nn_dot(2,2)*gains(2))*eye(3);

%% Compute the cross and SO3 components
M31 = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) M_nn_dot(1,2)*gains(1)/2*rot3_logDiffMat(RRef,R)...
    -M_nn_dot(2,3)*gains(1)/2*rot3_logDiffMat(RRef,R)...
    +M_nn_dot(1,3)/4*(-gains(3)*rot_log(eye(3),RRef))...
    +2*M_nn(1,3)*M_nn_dot(1,3)/4*(1/M_nn(3,3)*hat3(w))...
    +(M_nn(1,3)*M_nn_dot(2,3) + M_nn_dot(1,3)*M_nn(2,3))/4*(1/M_nn(3,3)*gains(1)*rot_log(eye(3),R'*RRef))...
    +(M_nn(1,3)*M_nn_dot(2,3) + M_nn_dot(1,3)*M_nn(2,3))/4*(-1/M_nn(3,3)*gains(2)*hat3(w))...
    -M_nn_dot(1,3)/2*gains(3)*rot3_logDiffMat(RRef,eye(3));
M32 = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) M_nn_dot(2,2)*gains(1)/2*rot3_logDiffMat(RRef,R)...
    +(M_nn_dot(1,3)-M_nn_dot(2,3)*gains(2))/2*eye(3)...
    +M_nn_dot(2,3)/4*(-gains(3)*rot_log(eye(3),RRef))...
    +(M_nn_dot(2,3)*M_nn(1,3) + M_nn(2,3)*M_nn_dot(1,3))/4*(1/M_nn(3,3)*hat3(w))...
    +2*M_nn(2,3)*M_nn_dot(2,3)/4*(1/M_nn(3,3)*gains(1)*rot_log(eye(3),R'*RRef))...
    +2*M_nn(2,3)*M_nn_dot(2,3)/4*(-1/M_nn(3,3)*gains(2)*hat3(w))...
    -M_nn_dot(2,3)/2*gains(3)*rot3_logDiffMat(RRef,eye(3));
M33 = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) M_nn_dot(2,3)*gains(1)*rot3_logDiffMat(R,RRef);

%% Construct the complete matrix by adding new terms from the reference manifold
% Note: beta should usually be set to 0, it is found via the optimization
% problem
M_ALL = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) [M11(R,w,RRef,gains,M_nn,M_nn_dot,beta) M21(R,w,RRef,gains,M_nn,M_nn_dot,beta)' M31(R,w,RRef,gains,M_nn,M_nn_dot,beta)';...
    M21(R,w,RRef,gains,M_nn,M_nn_dot,beta) M22(R,w,RRef,gains,M_nn,M_nn_dot,beta) M32(R,w,RRef,gains,M_nn,M_nn_dot,beta)';...
    M31(R,w,RRef,gains,M_nn,M_nn_dot,beta) M32(R,w,RRef,gains,M_nn,M_nn_dot,beta) M33(R,w,RRef,gains,M_nn,M_nn_dot,beta)]...
    + kron(beta*M_nn_dot,eye(3));

if flagOutputSymmetric
    M_ALL = @(R,w,RRef,gains,M_nn,M_nn_dot,beta) (M_ALL(R,w,RRef,gains,M_nn,M_nn_dot,beta) + M_ALL(R,w,RRef,gains,M_nn,M_nn_dot,beta)')/2;
end
end

