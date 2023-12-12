function [h] = plot_surfPlot_contractionGains(data)
% Plot a surface plot of the (par) gridData matrix
% INPUTS:
%   data := the structure of the data loaded from one of the data set
%       generated by par_rotBundle_contractionTest.m
% OUTPUTS:
%   h := handle to the figure

% Get kd values
A = data.gridData.gainData(:,:,1);
% Get kv values
B = data.gridData.gainData(:,:,2);
% Get the best beta
C = data.gridData.betaData;

figure
% C(find(abs(C)<1e-7))=Inf;
surf(A,B,C);
shading interp
colorbar('southoutside')
xlabel('$k_{d}$','Interpreter','latex')
ylabel('$k_{v}$','Interpreter','latex')
zlabel('$\beta$','Interpreter','latex')