%test for checking the functionality of the code and debugging it:
clear
close all
rng(1)

obstacle_list= [30 30 12;
                30 50 12;
                30 70 12;
                30 80 12;
                50 30 12;
                70 30 12;
                80 30 12]';
start = [0;0];
goal = [95;15];
max_itr = 50;
lim_x = [0 100];
lim_y = [0 100];
expand_dis = 100;
path_resolution = 1;


[~,obs,T,~,~,~]= main_test_RRTs(obstacle_list,start,goal,...
                                max_itr,lim_x,lim_y,expand_dis,...
                                path_resolution);

L = [];
l1 = [42 80;100 90;42 42;80 42]';
l2 = [0 0;30 18;80 18;80 0]';
l3 = [0 0;30 18;80 18;80 0]';
l4 = [0 0;30 18;18 80;0 90;18 30]';
% T = fitLandmarks(T,l1,l2,l3,l4);
% l = [58 58;40 30;20 10;2 2]';
T = fitLandmarks(T);
T = voronoi(T);
T = nearestObstacle(T, obs);
T = CLF_constraint(T);
T = CBF_constraint(T, obs);
T = find_controller(T,L);
% save('solved_tree.mat')

% figure(2)
start = [45;60];
navigate(start,T,obstacle_list,2,'r*');
% figure(2)
% plot_controllers(T,3);
