function problem=test_problem()

num_rows_stiefel = 4;
d = 3;
N = 5;

sz=[num_rows_stiefel,d,N];

L = [81.8237937948520	112.037661838045	4.73052451928088	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
112.037661838045	247.577031200868	1.60014831969606	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
4.73052451928088	1.60014831969606	0.526083238650238	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	229.285034693104	-88.3580191398148	49.4954861487324	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	-88.3580191398148	181.455563318464	-30.8804053991093	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	49.4954861487324	-30.8804053991093	11.9706656430406	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	269.835490711748	160.727358297256	25.1268150198972	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	160.727358297256	384.319877684063	-8.19784555662784	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	25.1268150198972	-8.19784555662784	6.55648694053350	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	255.844539274558	-73.5994397197616	57.4193278805093	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	-73.5994397197616	144.019017733910	-45.8685417544971	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	57.4193278805093	-45.8685417544971	22.0792535834134	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	156.836401283780	138.475503328774	-6.09759316329436	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	138.475503328774	163.008326733959	-20.1638141928065	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-6.09759316329436	-20.1638141928065	5.59857570162980	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];

P = [-163.472936424418	16.7969898749502	-220.787576755502;
-226.676185679509	15.3756583691586	-485.604306213875;
-9.30386375606613	1.36593705592931	-3.27166335660236;
0	0	0;
57.4391326418379	29.7138027956758	490.947942817551;
-288.823996294331	77.3884850116431	-272.767629301760;
33.9575255364760	-0.504318980545320	112.631391757572;
0	0	0;
258.286911980844	56.8749716789134	568.943337440766;
-175.540257283233	-11.5882399791785	804.871188525147;
50.6067516560441	13.7311217821795	15.5186102881273;
0	0	0;
302.771125130579	56.6740812907377	-446.581860060651;
61.6280844185141	17.7586853231790	320.204743789859;
31.2866647491704	8.92161856257658	-147.960804607440;
0	0	0;
158.064113201787	-14.2872430747735	-386.809444415604;
215.273674904962	-43.6495250509821	-369.165485583123;
-33.6108486755905	11.8134601464868	25.0651163506788;
0	0	0];

L = readmatrix("../data/L_stiefel_noisy.csv");
P = readmatrix("../data/P_stiefel_noisy.csv");
A = readmatrix("../data/A_stiefel_noisy.csv");
B = readmatrix("../data/B_stiefel_noisy.csv");
fixed_cost_term = readmatrix("../data/fixed_cost_term.csv");

problem=struct('sz',sz, ...
    'L',L,'P',P, ...
    'fixed_cost_term', fixed_cost_term, ...
    'A',A,'B',B);

problem.cost=@(x) cost(x,problem);
problem.egrad=@(x) egrad(x,problem);
problem.grad=@(x) rgrad(x,problem);
problem.ehess=@(x,u) ehess(x,u,problem);
problem.hess=@(x,u) rhess(x,u,problem);
problem.hess_rconn=@(x,u) rhess_rconn(x,u,problem);
problem.ahess_f=@(x,u) ahess_f(x,u,problem);
problem.bhess_f=@(x,u) bhess_f(x,u,problem);

end

function c=cost(x,problem)
xStack=matStack(x);
c=trace(xStack'*problem.L*xStack+xStack'*problem.P) + problem.fixed_cost_term;
end

function g=egrad(x,problem)
xStack=matStack(x);
g=matUnstack((problem.L+problem.L')*xStack+problem.P,problem.sz(1));
end

function g=rgrad(x,problem)
g=stiefel_tangentProj(x,egrad(x,problem));
end

function h=ehess(x,u,problem)
h = matUnstack((problem.L + problem.L')*matStack(u), problem.sz(1));
end

function h=rhess(x,u,problem)
eh = ehess(x,u,problem);
X = matStack(x);
X_dot = matStack(u);
U = matStack(egrad(x,problem));
stief_proj_differential = X_dot * (X' * U + U' * X) + ...
    X * (X_dot' * U + U' * X_dot);
h = stp_manopt(x, matUnstack(stief_proj_differential, problem.sz(1))) + ...
    stp_manopt(x, eh);
end

function h=rhess_rconn(x,u,problem)
xStack=matStack(x);
g=matUnstack((problem.L+problem.L')*xStack+problem.P,problem.sz(1));
rconn = stp_manopt(x, g);
end

% function Up = stp_boumal(X, U) %copied from stiefelfactory.m
%         
% XtU = multiprod(multitransp(X), U);
% symXtU = multisym(XtU);
% Up = U - multiprod(X, symXtU);
% 
% The code above is equivalent to, but faster than, the code below.
%         
%     Up = zeros(size(U));
%     function A = sym(A), A = .5*(A+A'); end
%     for i = 1 : k
%         Xi = X(:, :, i);
%         Ui = U(:, :, i);
%         Up(:, :, i) = Ui - Xi*sym(Xi'*Ui);
%     end
% 
% end

function h = ahess_f(x,u,problem)
A_stiefel = problem.A;
b = problem.B;
x_transl = reshape(x(:), problem.sz(1) * problem.sz(3), []);
u_transl = reshape(u(:), problem.sz(1) * problem.sz(3), []);
g = 2*(A_stiefel' * A_stiefel) * x_transl + 2*A_stiefel'*b; %??
h = 2.*(A_stiefel'*A_stiefel)*u_transl;
h = stp_manopt(x, matUnstack(h, problem.sz(1))) + ...
    stp_manopt(x, matUnstack(g, problem.sz(1)));
% stp_manopt(x, matUnstack(stief_proj_differential, problem.sz(1))) + ...
%     stp_manopt(x, eh);
end

function h = bhess_f(x,u,problem)
L = problem.L;
uSt = matStack(u);
xSt = matStack(x);
e = som_egrad_rot_stiefel(xSt,problem);
eSt = matStack(e);
eDer = (L + L') * xSt;
sndPartA = uSt * xSt' * eSt + xSt * uSt' * eSt + xSt * xSt' * eDer;
sndPartB = uSt * eSt' * xSt + xSt * eDer' * xSt + xSt * eSt' * uSt;
sndPart = 0.5 .* (sndPartA + sndPartB);
h = (L + L')*uSt - sndPart;
h = matUnstack(h, problem.sz(1));
end

