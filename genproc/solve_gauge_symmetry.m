nrs = 4; %change to nrs = 5 to test it
d = 3;
N = 5;


% R_i = make_rand_stiefel_3d_array(nrs, d, N);
% T_i = 10 * rand(nrs, N);

% POCRotateToMinimizeLastEntries() ...

R = zeros(nrs, d, N);
R(:,:,1) =[
  -0.633009696201651   0.365785469183794  -0.681552411978719;
   0.300903918334628   0.927837726173271   0.216622242688311;
  -0.713120554234337   0.066181708519839   0.694831963559858;
  -0.014650309692048   0.030628840673481   0.075958252443225];
R(:,:,2) =[
  -0.812728367573879   0.364762014232424   0.418766102871191;
   0.079417601237271  -0.664534191278519   0.502715344803537;
   0.478086669628382   0.364716187242740   0.738515371539764;
   0.323417039560469   0.540670957568491  -0.162810562263695];
R(:,:,3) =[
   0.111053954925067   0.177477305244115   0.961827739577185;
   0.332264361402711   0.718792405475127  -0.271244238005747;
   0.930324009264719  -0.203198726571996  -0.014043867783920;
   0.108464976018847  -0.640741415450950  -0.033417547878209];
R(:,:,4) =[
   0.802707958560606   0.569735175619352   0.002353364399888;
  -0.348949474173510   0.325241590467006  -0.687813737114413;
   0.422731050230770  -0.498396630273226  -0.692740191566677;
   0.234931174832727  -0.566763210189909   0.216835771266807];
R(:,:,5) =[
   0.364717163475128   0.244934411691577  -0.897332776488672;
  -0.591701607362632   0.779542628572305  -0.037217492655861;
  -0.667380656121294  -0.574810862029427  -0.436756991949220;
   0.267345578505134  -0.043736679124839   0.051498315147307];

% T = zeros(nrs,N);
T = [5.52989200497386	-3.23868362853368	-7.57164584572133	-0.347137118025300	6.40077586933894;
-4.40050299467541	-2.74607885107208	1.60648817904566	4.71944333560070	-0.729181940525049;
-5.73635735107686	-7.22243705954438	0.0545123672074450	6.10779249344889	4.55609031254877;
-0.423968727476036	-0.177903011520358	0.614132793616925	-0.874411109442508	0.862364178906416];


%%

x = [matStackH(R), T];
[Q,~,~]=svd(x*x');
disp('x=')
disp(x)
disp('Q''*x=')
disp(Q'*x)

% transf_out = RT2G(matUnstackH(x), T(1:d, 1:N));

%% by hand (Manopt)
problem.M = stiefelfactory(nrs,nrs);
P_zeros = zeros(nrs-d, d);
P = [P_zeros, eye(nrs-d)];

problem.cost = @(Q) norm(P*Q'*x);
problem = manoptAD(problem);

[Q_out, Q_cost, ~, ~] = trustregions(problem);

disp("Q_out")
disp(Q_out)

disp("Q_out * x")
disp(Q_out * x)

% disp("multidet(matUnstackH(Q_out * x, d))");
% Xtrue = matUnstackH(Q_out * x, d);
% disp(multidet(Xtrue(1:d, 1:d, :)));

