function [x0, xd, xd_dd, LfB, LgB, Bf, h_i, x_i, y_i, r_i, axisBound] = obs_dynamicTraj(m)
% Create obstacles, initial condition, desired trajectory such that the
% point mass will get stuck in a local minimum
% INPUTS:
%   m := mass of point mass
% OUTPUTS:
%   x0 := initial condition
%   xd := desired trajectory
%   xd_dd := 2nd time derivative of xd (acceleration), used as feedfoward
%       in the control
%   LfB := Lie Derivative of B wrt f (no control)
%   Lgb := Lie Derivative of B wrt g (control)
%   Bf := The barrier function
%   h_i := psudo function to extend constraint equation (g_i) to the whole
%      state space
%   x_i := x positions of the circular obstacles
%   y_i := y positions of the circluar obstacles
%   r_i := radius of the circular obstacles

% Create obstacles and their dynamics
x_i = @(t) [10;15;-5]; % Obs x pos
dx_i = @(t) [0;0;0]; % Obs x vel
ddx_i = @(t) [0;0;0]; % Obs x accel
A = 15; % Amplitude of moving obstacle
w = 1/3; % Rate of moving obstacle
y_i = @(t) [15;10;A*sin(w*t)]; % Obs y pos
dy_i = @(t) [0;0;A*w*cos(w*t)]; % Obs y vel
ddy_i = @(t) [0;0;-A*w^2*sin(w*t)]; % Obs y accel
r_i = @(t) 5*[1;1;1]; % Radius of obs
gamma_i = 4*[1;1;1];
g_i = @(t, x) (x(1) - x_i(t)).^2 + (x(2)-y_i(t)).^2 - r_i(t).^2;
dg_i = @(t, x) 2*(x(1)-x_i(t)).*(x(3)-dx_i(t)) + 2*(x(2)-y_i(t)).*(x(4)-dy_i(t));
%%% alpha = g
alpha_i = @(t, x) g_i(t,x); % alpha is a class k function = 1/2*(g_i)^2
dalpha_i = @(t, x) 1; % alpha is a class k function = (g_i)^2
%%%
h_i = @(t, x) gamma_i.*alpha_i(t,x) + dg_i(t,x);
LfB = @(t, x) -( gamma_i.*dalpha_i(t,x).*dg_i(t,x) ...
    + 2*(x(3)-dx_i(t)).^2 ...
    - 2*(x(1)-x_i(t)).*ddx_i(t)...
    + 2*(x(4)-dy_i(t)).^2 ...
    - 2*(x(2)-y_i(t)).*ddy_i(t) );
LgB = @(t, x) -[2/m*(x(1) - x_i(t)), 2/m*(x(2) - y_i(t))];
Bf = @(t, x) 1./h_i(t,x);
% Assume field is 100x100 grid
x0 = [35;35;0;0]; % [x, y, vx, vy]
xd = @(t) [10*sin(t)+5; 10*cos(t)+5; 10*cos(t); -10*sin(t)]; % Stationary Trajectory
xd_dd = @(t) [-10*sin(t);-10*cos(t)];
% Set the boundary for the display
axisBound = [-15 40 -15 40];

end

